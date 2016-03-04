//
//  RDTv2Channel.swift
//  homesdk
//
//  Created by David Lin on 2/26/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class RDTv2Channel: IChannel {
    static let commandBegin: NSData = {
        let data = NSMutableData()
        data.appendByte(0x01)
        data.appendByte(0x02)
        return data
    }()
    
    static let commandEnd: NSData = {
        let data = NSMutableData()
        data.appendByte(0x03)
        data.appendByte(0x04)
        return data
    }()
    
    static let LENGTH_COMMANDLENGTH = 2
    static let LENGTH_SERNO = 4
    static let LENGTH_TOTALCOUNT = 1
    static let LENGTH_COUNTINDEX = 1
    
    var versionComponents: [String]? = ["2", "0", "0"]
    public var version: String {
        get { return self.version }
        set(value) { versionComponents = value.componentsSeparatedByString(".") }
    }
    
    public func concatChannelInfo(content: NSData?, _ objs: AnyObject...) throws -> [NSData] {
        try checkVersionInitialization()
        
        var content_ = NSData()
        if content != nil { content_ = content! }
        
        if objs.count != 1 {
            throw NSError(domain: "HOMESDK", code: 2, userInfo: [NSLocalizedDescriptionKey: "no define serno or objs.length != 1"])
        }
        
        let serno = Int(objs[0] as! NSNumber)
        
        let maxContentLength = 65535 - RDTv2Channel.LENGTH_SERNO - RDTv2Channel.LENGTH_TOTALCOUNT - RDTv2Channel.LENGTH_COUNTINDEX
        
        if maxContentLength >= content_.length {
            let data = NSMutableData()
            data.appendByte(0x01)
            data.appendByte(0x00)
            data.appendData(content_)
            return [makeCommand(serno, content: data)]
        } else {
            let totalCount = Int(ceil(Double(content_.length) / Double(maxContentLength)))
            var list: [NSData] = []
            for i in 0..<totalCount {
                let startInclusive = i * maxContentLength
                var endExclusive = (i+1) * maxContentLength
                if endExclusive > content_.length {
                    endExclusive = content_.length
                }
                
                let buf = NSMutableData()
                buf.appendByte(UInt8(totalCount))
                buf.appendByte(UInt8(i))
                buf.appendData(content_.subdataWithRange(NSRange(location: startInclusive, length: endExclusive - startInclusive)))
                list.append(makeCommand(serno, content: buf))
                    
                if endExclusive == content_.length {
                    break;
                }
            }
            return list
        }
    }
    
    private func makeCommand(serno: Int, content contentOpt: NSData?) -> NSData {
        let commandLength = RDTv2Channel.LENGTH_SERNO + (contentOpt == nil ? 0 : contentOpt!.length)
        
        let command = NSMutableData()
        
        command.appendData(RDTv2Channel.commandBegin)
        command.appendShort(UInt16(commandLength))
        command.appendWord(UInt32(serno))
        if let content = contentOpt { command.appendData(content) }
        command.appendData(RDTv2Channel.commandEnd)
        
        return command
    }
    
    public func segment(buf: NSData) throws -> [NSData] {
        return []
    }
    
    public func checkVersionInitialization() throws {
        if versionComponents == nil {
            throw NSError(domain: "HOMESDK", code: 0, userInfo: [NSLocalizedDescriptionKey: "no define version"]) }
        if versionComponents![0] != "2" {
            throw NSError(domain: "HOMESDK", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid version!"])
        }
    }
    
    public func compareVersion(version: String) -> Bool {
        let verArray = version.componentsSeparatedByString(".")
        if verArray.count != 3 { return false }
        return self.versionComponents! == verArray
    }
}
