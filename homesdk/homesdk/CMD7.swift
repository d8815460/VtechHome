//
//  CMD7.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class CMD7: ICommand {
    private static let OPERATION = 7
    private static let STAGE = 5
    
    let dev: Device
    
    init(dev: Device) { self.dev = dev }
    
    public func build(channel: IChannel, obj: AnyObject) throws -> [NSData] {
        var commandSet: [NSData] = []
        if let cmdArgs = obj as? Args {
            let content = cmdArgs.data
            commandSet.appendContentsOf(try channel.concatChannelInfo(content, CMD7.OPERATION, CMD7.STAGE))
        }
        return commandSet
    }
    
    public func parse(content: NSData) -> Bool {
        let obj = Content(content: content)
        dev.auth = obj.auth
        return true
    }
    
    public class Args {
        public var password = ""
        
        public var data: NSData {
            let result = NSMutableData()
            result.appendString(password)
            for _ in result.length...32 {
                result.appendByte(0)
            }
            return result
        }
    }
    
    public class Content {
        let auth: Bool
        
        init(content: NSData?) {
            guard let data = content else {
                auth = false
                return
            }
            
            let raw = UnsafePointer<UInt8>(data.bytes)
            auth = raw[0] >= 1
            return
        }
    }
}
