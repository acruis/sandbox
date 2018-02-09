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

    var inputStream: InputStream?
    private let writer = Writer()
    private let reader = Reader()

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
    
    // - MARK: ReaderDelegate
    
    func packageReceived(package: String) {
        print(package)
    }
}
