//
//  CMD17.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class CMD17: ICommand {
    private static let OPERATION = 17
    private static let STAGE = 5
    
    let dev: Device
    
    init(dev: Device) { self.dev = dev }
    
    public func build(channel: IChannel, obj: AnyObject) throws -> [NSData] {
        var commandSet: [NSData] = []
        commandSet.appendContentsOf(try channel.concatChannelInfo(nil, CMD17.OPERATION, CMD17.STAGE))
        return commandSet
    }
    
    public func parse(content: NSData) -> Bool {
        let obj = Content(content: content)
        dev.types = obj.types
        return true
    }
    
    public class Content {
        var types: [Int] = []
        
        init(content contentOpt: NSData?) {
            guard let content = contentOpt else { return }
            
            let count = UnsafePointer<UInt8>(content.bytes)[0]
            let raw32 = UnsafePointer<UInt32>(content.bytes+1)

            for i in 0..<count {
                types.append(Int(CFSwapInt32LittleToHost(raw32[Int(i)])))
            }
        }
    }
}
