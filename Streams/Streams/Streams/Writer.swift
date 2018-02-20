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
            errorOccurred()
        case .hasSpaceAvailable:
            writeToStream()
        default:
            break
        }
    }
    
    // - MARK: Stream diagnostics
    
    func printPortAndIP() {
        guard let outputStream = outputStream else {
            return
        }
        
        // Get the socket handle.
        let socketHandleDataRef = outputStream.property(forKey: Stream.PropertyKey(CFStreamPropertyKey.socketNativeHandle.rawValue as String)) as CFTypeRef
        guard CFGetTypeID(socketHandleDataRef) == CFDataGetTypeID() else {
            return
        }
        let socketHandleData = socketHandleDataRef as! CFData
        
        // Get the socket.
        let socketPointer = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
        CFDataGetBytes(socketHandleData, CFRangeMake(0, MemoryLayout<CFSocketNativeHandle>.size), socketPointer)
        guard let socket = CFSocketCreateWithNative(nil, CFSocketNativeHandle(socketPointer.pointee), 0, nil, nil) else {
            return
        }
        
        // Get the socket address.
        let addressDataRef = CFSocketCopyPeerAddress(socket) as CFTypeRef
        guard CFGetTypeID(addressDataRef) == CFDataGetTypeID() else {
            return
        }
        let addressData = addressDataRef as! CFData
        
        // Convert it into sockaddr_storage.
        guard let sockAddressRawPointer = UnsafeRawPointer(CFDataGetBytePtr(addressData)) else {
            return
        }
        
        var sockAddress = sockAddressRawPointer.bindMemory(to: sockaddr_in.self, capacity: 1).pointee
        var addressStringBytes = [Int8](repeating: 0, count: Int(INET_ADDRSTRLEN))
        inet_ntop(Int32(sockAddress.sin_family), &(sockAddress.sin_addr), &addressStringBytes, socklen_t(INET_ADDRSTRLEN))
        let addressString = String(cString: addressStringBytes)
        
        print("Port: \(sockAddress.sin_port.bigEndian)") // Network byte order is defined to always be big-endian.
        print("IP Address: \(addressString)")
        print("Raw string bytes: \(addressStringBytes)")
    }
}
