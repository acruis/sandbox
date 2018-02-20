//
//  Reader.swift
//  Streams
//
//  Created by Nguyen Quoc Dat on 9/2/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

protocol ReaderDelegate {
    func packageReceived(package: String)
}

import Foundation

class Reader: NSObject, StreamDelegate {
    var stringToProcess = ""
    private var inputStream: InputStream?
    let readBufferSize = 6
    private var delegate: ReaderDelegate?
    
    func setInputStream(inputStream: InputStream, delegate: ReaderDelegate) {
        self.inputStream = inputStream
        inputStream.delegate = self
        self.delegate = delegate
    }
    
    func readIntoString() {
        guard let inputStream = self.inputStream else {
            return
        }
        
        var readBuffer = [UInt8](repeating: 0, count: readBufferSize)
        let bytesRead = inputStream.read(&readBuffer, maxLength: readBufferSize)
        
        if bytesRead < 1 {
            return
        }
        
        guard let readString = String(data: Data(readBuffer[..<bytesRead]), encoding: .utf8) else {
            return
        }
        
        self.stringToProcess = self.stringToProcess + readString
        processString()
    }
    
    private func errorOccurred() {
        // We don't deal with error-occurred situation here, as we already deal with it in the Writer side,
        // and the streams are coupled.
        self.inputStream?.close()
        self.inputStream = nil
        self.stringToProcess = ""
    }
    
    private func processString() {
        var messageParts = stringToProcess.components(separatedBy: ":::")
        
        if messageParts.count < 2 {
            return
        }
        
        self.stringToProcess = messageParts.removeLast()
        messageParts.forEach { messagePart in
            self.delegate?.packageReceived(package: messagePart)
        }
    }
    
    // - MARK: StreamDelegate
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .errorOccurred:
            errorOccurred()
        case .hasBytesAvailable:
            readIntoString()
        default:
            break
        }
    }
}
