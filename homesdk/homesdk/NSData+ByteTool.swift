//
//  ByteTool.swift
//  homesdk
//
//  Created by David Lin on 2/24/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

extension NSData {
    var hexString: String {
        let pointer = UnsafePointer<UInt8>(bytes)
        let array = getByteArray(pointer)
        
        return array.reduce("") { (result, byte) -> String in
            result.stringByAppendingString(String(format: "%02x", byte))
        }
    }
    
    private func getByteArray(pointer: UnsafePointer<UInt8>) -> [UInt8] {
        let buffer = UnsafeBufferPointer<UInt8>(start: pointer, count: length)
        
        return [UInt8](buffer)
    }
    
    public func getShortAt(index: Int) -> UInt16 {
        let subData = self.subdataWithRange(NSRange(location: index, length: 2))
        let raw = UnsafePointer<UInt16>(subData.bytes)
        return CFSwapInt16LittleToHost(raw[0])
    }
    
    public func getByteAt(index: Int) -> UInt8 {
        let subData = self.subdataWithRange(NSRange(location: index, length: 1))
        let raw = UnsafePointer<UInt8>(subData.bytes)
        return raw[0]
    }
    
    public func getWordAt(index: Int) -> UInt32 {
        let subData = self.subdataWithRange(NSRange(location: index, length: 4))
        let raw = UnsafePointer<UInt32>(subData.bytes)
        return CFSwapInt32LittleToHost(raw[0])
    }
}

extension NSMutableData {
    public func appendString(str: String) {
        if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
            self.appendData(data)
        }
    }
    public func appendByte(data: UInt8) {
        var raw = data
        withUnsafePointer(&raw) {
            let data = NSData(bytes: $0, length: 1)
            self.appendData(data)
        }
    }
    
    public func appendShort(data: UInt16) {
        var raw = CFSwapInt16HostToLittle(data)
        withUnsafePointer(&raw) {
            let data = NSData(bytes: $0, length: 2)
            self.appendData(data)
        }
    }
    
    public func appendWord(data: UInt32) {
        var raw = CFSwapInt32HostToLittle(data)
        withUnsafePointer(&raw) {
            let data = NSData(bytes: $0, length: 4)
            self.appendData(data)
        }
    }
}