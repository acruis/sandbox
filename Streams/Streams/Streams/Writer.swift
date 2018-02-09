//
//  Writer.swift
//  Streams
//
//  Created by Nguyen Quoc Dat on 6/2/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

class Writer: NSObject, StreamDelegate {
    var dataToWrite = Data()
    private var outputStream: OutputStream?
    let writeBufferSize = 32768
    
    private var streamErrorOccurred: (() -> Void)?
    
    func setOutputStream(outputStream: OutputStream, streamErrorOccurred: @escaping () -> Void) {
        self.outputStream = outputStream
        self.streamErrorOccurred = streamErrorOccurred
        outputStream.delegate = self
    }
    
    func sendMessage(message: String) {
        dataToWrite = dataToWrite + message.utf8
        writeToStream()
    }
    
    private func writeToStream() {
        guard let outputStream = outputStream else {
            return
        }
        
        if dataToWrite.isEmpty {
            return
        }
        
        let bytesToSend = min(dataToWrite.count, writeBufferSize)
        let dataToSend = [UInt8](dataToWrite[0..<bytesToSend])
        let bytesWritten = outputStream.write(dataToSend, maxLength: bytesToSend)
        
        if bytesWritten > 0 {
            dataToWrite.removeSubrange(0..<bytesWritten)
        }
    }
    
    private func errorOccurred() {
        self.outputStream?.close()
        self.outputStream = nil
        self.dataToWrite = Data()
        self.streamErrorOccurred?()
    }
    
    // - MARK: StreamDelegate
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .errorOccurred:
            self.errorOccurred()
            break
        case .hasSpaceAvailable:
            writeToStream()
            break
        default:
            break
        }
    }
}
