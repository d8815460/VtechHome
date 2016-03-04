//
//  CMD3.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class CMD3: ICommand {
    private static let OPERATION = 3
    private static let STAGE = 5
    
    let dev: Device
    
    init(dev: Device) { self.dev = dev }
    
    public func build(channel: IChannel, obj: AnyObject) throws -> [NSData] {
        var commandSet: [NSData] = []
        commandSet.appendContentsOf(try channel.concatChannelInfo(nil, CMD3.OPERATION, CMD3.STAGE))
        return commandSet
    }
    
    public func parse(content: NSData) -> Bool {
        let obj = Content(content: content)
        dev.productName = obj.productName
        return true
    }
    
    public class Content {
        let productName: String
        
        init(content: NSData?) {
            guard let content_ = content else {
                productName = ""
                return
            }
            
            let raw = UnsafePointer<UInt8>(content_.bytes)
            var index = -1
            for i in (content_.length-1).stride(through: 0, by: -1) {
                if raw[i] == 0x00 {
                    continue
                } else {
                    index = i;
                    break;
                }
            }
            
            if index >= 0 {
                let data = content_.subdataWithRange(NSRange(location: 0, length: index+1))
                if let name = String(data: data, encoding: NSUTF8StringEncoding) {
                    productName = name
                } else {
                    productName = ""
                }
            } else {
                productName = ""
            }
        }
    }
}
