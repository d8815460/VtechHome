//
//  CMD2.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class CMD2: ICommand {
    private static let OPERATION = 2
    private static let STAGE = 3
    
    let dev: Device

    init(dev: Device) { self.dev = dev }
    
    public func build(channel: IChannel, obj: AnyObject) throws -> [NSData] {
        var commandSet: [NSData] = []
        if let cmdArgs = obj as? Args {
            let content = cmdArgs.data
            commandSet.appendContentsOf(try channel.concatChannelInfo(content, CMD2.OPERATION, CMD2.STAGE))
        }
        return commandSet
    }
    
    public func parse(content: NSData) -> Bool {
        let obj = Content(content: content)
        dev.productCode = AppConfig.productCodeSet.map(obj.productCode)
        return true
    }
    
    public class Args {
        public let productCode = 0xFF
        
        public var data: NSData {
            let result = NSMutableData()
            result.appendByte(UInt8(productCode))
            result.appendByte(UInt8(0))
            return result
        }
    }
    
    public class Content {
        let productCode: Int
        
        init(content: NSData?) {
            guard let content_ = content else {
                productCode = 0
                return
            }
            
            let raw = UnsafePointer<UInt8>(content_.bytes)
            productCode = (0x0FFFF & ((Int(raw[0]) & 0x00FF) | ((Int(raw[1]) << 8) & 0x0FF00)))
        }
    }
}
