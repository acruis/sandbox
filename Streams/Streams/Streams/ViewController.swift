//
//  ViewController.swift
//  Streams
//
//  Created by Nguyen Quoc Dat on 5/2/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReaderDelegate {
    @IBOutlet weak var userIDTextField: UITextField!

    private let writer = Writer()
    private let reader = Reader()
    private let paralyzer = Paralyzer()
    
    private var paralyzingStream: OutputStream? // Only one is enough; even if the other is dealloc'd the connection is maintained.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recreateStreams()
    }
    
    func recreateStreams() {
        var unretainedInputStream: Unmanaged<CFReadStream>?
        var unretainedOutputStream: Unmanaged<CFWriteStream>?
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "127.0.0.1" as CFString, 5000, &unretainedInputStream, &unretainedOutputStream)

        guard let inputStream: InputStream = unretainedInputStream?.takeRetainedValue(),
            let outputStream: OutputStream = unretainedOutputStream?.takeRetainedValue() else {
            return
        }
        
        inputStream.schedule(in: .current, forMode: .defaultRunLoopMode)
        self.reader.setInputStream(inputStream: inputStream, delegate: self)
        
        outputStream.schedule(in: .current, forMode: .defaultRunLoopMode)
        self.writer.setOutputStream(outputStream: outputStream, streamErrorOccurred: self.recreateStreams)
        
        inputStream.open()
        outputStream.open()
    }
    
    func streamErrorOccurred() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: self.recreateStreams)
    }
    
    @IBAction func sendUserID(_ sender: UIButton) {
        guard let userID = userIDTextField.text else {
            return
        }
        
        writer.sendMessage(message: "{\"command\":99,\"requestID\":100000,\"payload\":\"\(userID)\"}:::")
    }
    
    @IBAction func printPortAndIPAddress() {
        writer.printPortAndIP()
    }
    
    // - MARK: ReaderDelegate
    
    func packageReceived(package: String) {
        print(package)
    }
    
    // - MARK: Destruction
    
    @IBAction func establishParalyzingStream(_ sender: UIButton) {
        var inputStream: InputStream?
        
        Stream.getStreamsToHost(withName: "127.0.0.1", port: 5000, inputStream: &inputStream, outputStream: &paralyzingStream)
        
        guard let paralyzingStream = paralyzingStream else {
            return
        }
        
        paralyzingStream.schedule(in: .current, forMode: .defaultRunLoopMode)
        self.paralyzer.setParalyzingStream(stream: paralyzingStream)
        
        paralyzingStream.open()
    }
}
