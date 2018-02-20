//
//  Paralyzer.swift
//  Streams
//
//  Created by Nguyen Quoc Dat on 20/2/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import Foundation

class Paralyzer: NSObject, StreamDelegate {
    var paralyzingStream: OutputStream?
    
    func setParalyzingStream(stream: OutputStream) {
        self.paralyzingStream = stream
        stream.delegate = self
    }
    
    func writeOnOpenCompleted() {
        let anyString = [UInt8]("Any String".utf8)
        let bytesWritten = paralyzingStream?.write(anyString, maxLength: anyString.count)
        print(bytesWritten!) // -1
    }
    
    // - MARK: StreamDelegate
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .openCompleted:
            writeOnOpenCompleted()
        case .errorOccurred:
            print("Paralyzing stream error!") // Printed
        default:
            break
        }
    }
}
