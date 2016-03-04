//
//  CMD24.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class CMD24: ICommand {
    private static let OPERATION = 24
    private static let STAGE = 5
    
    let dev: Device
    
    init(dev: Device) { self.dev = dev }
    
    public func build(channel: IChannel, obj: AnyObject) throws -> [NSData] {
        var commandSet: [NSData] = []
        if let cmdArgs = obj as? Args {
            let content = cmdArgs.data
            commandSet.appendContentsOf(try channel.concatChannelInfo(content, CMD24.OPERATION, CMD24.STAGE))
        }
        return commandSet
    }
    
    public func parse(content: NSData) -> Bool {
        let obj = Content(content: content, parent: self)
        for acc in obj.list {
            let key = AccessoryManager.Key(uid: dev.uid, aid: acc.aid, type: acc.type)
            AccessoryManager.sharedInstance.accessories[key] =  acc
        }
        return true
    }
    
    public class Args {
        public let type: Int = 0
        
        public var data: NSData {
            let result = NSMutableData()
            result.appendWord(CFSwapInt32HostToLittle(UInt32(type)))
            return result
        }
    }
    
    public class Content {
        public var list: [Accessory] = []
        
        init(content contentOpt: NSData?, parent: CMD24) {
            guard let content = contentOpt else {
                return
            }
            
            let raw = UnsafePointer<UInt8>(content.bytes)
            var index = 1
            while index < content.length {
                HomeLog.systemLog("content[index]: \(String(format: "%02X", raw[index]))")
                let aid = Int(raw[index])
                index += 1
                
                let type = AppConfig.accessoryTypeSet.map(Int(content.getWordAt(index)))
                index += 4
                
                let key = AccessoryManager.Key(uid: parent.dev.uid, aid: aid, type: type)
                
                var acc = AccessoryManager.sharedInstance.accessories[key]
                if acc == nil {
                    acc = AppConfig.accessoryCreator.create(parent.dev.uid, aid: aid, type: type)
                } else {
                    acc!.attributes.removeAll()
                }
                
                let functionAmount = Int(raw[index])
                index += 1
                
                for _ in functionAmount.stride(to: 0, by: -1) {
                    let functionCode = Int(raw[index])
                    index += 1
                    HomeLog.systemLog("functinoCode: \(functionCode)")
                    
                    let functionCodeAmount = Int(raw[index])
                    index += 1
                    
                    let functionCodeInfo = content.subdataWithRange(NSRange(location: index, length: 2 * functionCodeAmount))
                
                    index += functionCodeInfo.length
                    let code = AppConfig.v1FunctionCodeSet.map(functionCode, type)
                    acc!.attributes[code] = code.parse(functionCodeInfo)!
                }
                list.append(acc!)
            }
        }
    }
}
