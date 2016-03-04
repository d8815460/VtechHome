//
//  CMD29.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class CMD29: ICommand {
    private static let OPERATION = 29
    private static let STAGE = 5
    
    let dev: Device
    
    init(dev: Device) { self.dev = dev }
    
    public func build(channel: IChannel, obj: AnyObject) throws -> [NSData] {
        var commandSet: [NSData] = []
        commandSet.appendContentsOf(try channel.concatChannelInfo(nil, CMD29.OPERATION, CMD29.STAGE))
        return commandSet
    }
    
    public func parse(content: NSData) -> Bool {
        let obj = Content(content: content)
        dev.version = obj.version
        return true
    }
    
    public class Content {
        let version: String
        
        init(content contentOpt: NSData?) {
            guard let content = contentOpt else {
                version = ""
                return
            }

            version = "\(content.getShortAt(0)).\(content.getShortAt(2)).\(content.getWordAt(4))"
        }
    }
}
