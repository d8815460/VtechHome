//
//  RDTv1Channel.swift
//  homesdk
//
//  Created by David Lin on 2/24/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

public class RDTv1Channel: IChannel {
    static let commandBegin: NSData = "IOTC".dataUsingEncoding(NSUTF8StringEncoding)!
    static let commandEnd: NSData = "GC".dataUsingEncoding(NSUTF8StringEncoding)!
    
    static let LENGTH_STAGE = 1
    static let LENGTH_OPERATION = 2
    static let LENGTH_TOTALCOUNT = 1
    static let LENGTH_COUNTINDEX = 1
    
    private var versionComponents: [String]? = ["1", "0", "0"]
    public var version: String {
        get { return self.version }
        set(value) { versionComponents = value.componentsSeparatedByString(".") }
    }
    
    var map: [Int: [NSData]] = [:]
    var partialCommand: NSData?
    
    public func concatChannelInfo(content: NSData?, _ objs: AnyObject...) throws -> [NSData] {
        try checkVersionInitialization()
        
        var operation: UInt16
        var stage: UInt8
        
        if objs.count == 2 {
            var tmp = objs[0] as! Int
            operation = UInt16(tmp)
            tmp = objs[1] as! Int
            stage = UInt8(tmp)
        } else {
            throw NSError(domain: "HOMESDK", code: 2, userInfo: [NSLocalizedDescriptionKey: "no define operation or stage"])
        }
        
        let supportSlice = supportSliceWhenBuilding(operation)
        let length2Bytes = compareVersion("1.1.0")
        
        if !supportSlice {
            var list: [NSData] = []
            list.append(makeCommand(operation, stage: stage, content: content, length2Byte: length2Bytes));
            return list;

        }
        
        let maxContentLength = (length2Bytes ? 65535 : 255) - RDTv1Channel.LENGTH_STAGE -
            RDTv1Channel.LENGTH_OPERATION - RDTv1Channel.LENGTH_TOTALCOUNT - RDTv1Channel.LENGTH_COUNTINDEX
        
        var len = 0
        if let cont = content { len = cont.length }
        
        if maxContentLength >= len {
            var list: [NSData] = []
            let mutableData = NSMutableData()
            mutableData.appendByte(1)
            mutableData.appendByte(0)
            mutableData.appendData(content!)
            list.append(makeCommand(operation, stage: stage, content: mutableData, length2Byte: length2Bytes))
            return list
        }
        
        let totalCount = (Int)(ceil(Double(len) / Double(maxContentLength)))
        
        var list: [NSData] = []
        for i in 0..<totalCount {
            let startInclusive = i * maxContentLength
            var endExclusive = (i + 1) * maxContentLength
            if endExclusive > len {
                endExclusive = len
            }
            
            let buff = NSMutableData(capacity: endExclusive - startInclusive)!
            
            buff.appendByte((UInt8)(totalCount & 0x0FF))
            buff.appendByte((UInt8)(i & 0x0FF))
            buff.appendData(content!.subdataWithRange(NSRange(location: startInclusive, length: endExclusive - startInclusive)))
            list.append(makeCommand(operation, stage: stage, content: buff, length2Byte: length2Bytes))
                
            if endExclusive == len {
                break;
            }
        }
        return list;
    }
    
    private func makeCommand(operation: UInt16, stage: UInt8, content contentOpt: NSData?, length2Byte: Bool) -> NSData {
        let contentLength = contentOpt == nil ? 0 : contentOpt!.length
        let commandLength = RDTv1Channel.LENGTH_STAGE + RDTv1Channel.LENGTH_OPERATION + contentLength
        let command = NSMutableData()

        command.appendData(RDTv1Channel.commandBegin)
        
        if length2Byte {
            command.appendShort(UInt16(commandLength))
        } else {
            command.appendByte(UInt8(commandLength))
        }
        command.appendByte(stage)
        command.appendShort(operation)

        if let content = contentOpt {
            command.appendData(content)
        }
        command.appendData(RDTv1Channel.commandEnd)
        
        return command
    }
    
    public func segment(buf: NSData) throws -> [NSData] {
        let ERROR_TAG = "SEGMENT_ERROR"
        try checkVersionInitialization()
        
        let length2Byte = compareVersion("1.1.0")
        let data = UnsafePointer<UInt8>(buf.bytes)
        var list: [NSData] = []
        if buf.length == 0 { return list }
        return list
    }
    
    public func checkVersionInitialization() throws {
        if versionComponents == nil {
            throw NSError(domain: "HOMESDK", code: 0, userInfo: [NSLocalizedDescriptionKey: "no define version"]) }
        if versionComponents![0] != "1" {
            throw NSError(domain: "HOMESDK", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid version!"])
        }
    }
    
    public func compareVersion(version: String) -> Bool {
        let verArray = version.componentsSeparatedByString(".")
        if verArray.count != 3 { return false }
        return self.versionComponents! == verArray
    }
    
    func supportSliceWhenBuilding(operation: UInt16) -> Bool {
        switch operation {
        case 20: fallthrough
        case 27: fallthrough
        case 28: fallthrough
        case 30: fallthrough
        case 32: fallthrough
        case 33: return true
        default: return false
        }
    }
    
    func supportSliceWhenSegment(operation: UInt16) -> Bool {
        switch operation {
        case 19: fallthrough
        case 20: fallthrough
        case 24: fallthrough
        case 27: fallthrough
        case 28: fallthrough
        case 30: fallthrough
        case 31: fallthrough
        case 32: fallthrough
        case 33: return true
        default: return false
        }
    }
}