//
//  CMDGetAuthentication.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class CMDGetAuthentication: ICommand {
    private static let OPERATION = "read"
    private static let TARGET = "/accessory/0/authentication"
    
    private let dev: Device
    
    init(dev: Device) { self.dev = dev }
    
    public func build(channel: IChannel, obj: AnyObject) throws -> [NSData] {
        var commandSet: [NSData] = []
        if let commandArgs = obj as? Args {
            let content = commandArgs.toJSONObject()
            let str = content.rawString()!
            commandSet.appendContentsOf(try channel.concatChannelInfo(str.dataUsingEncoding(NSUTF8StringEncoding)!, commandArgs.serno))
        }
        return commandSet
    }
    
    public func parse(content: NSData) -> Bool {
        return false
    }

    public func getArgs() -> Args { return Args() }
    
    public class Args {
        var serno = 0
        var password = ""
        
        private func toJSONObject() -> JSON {
            let obj = JSON([
                "serno" : serno,
                "operation": CMDGetAuthentication.OPERATION,
                "target": CMDGetAuthentication.TARGET,
                "request": [
                    "password": password
                ]
            ])
            
            let str = obj.rawString()!
            HomeLog.systemLog("getAuth JSON length: \(str.characters.count)")
            HomeLog.systemLog("getAuth JSON: \(str)")
            return obj
        }
    }
}
