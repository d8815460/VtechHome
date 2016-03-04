//
//  Accessory.swift
//  homesdk
//
//  Created by David Lin on 2/26/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public protocol Accessory_CREATOR {
    func create(uid: String, aid: Int, type: AccessoryTypeSet.AccessoryType) -> Accessory
}

public class Accessory: NSObject {
    public let uid: String
    public let aid: Int
    public let type: AccessoryTypeSet.AccessoryType
    public var attributes: [V1FunctionCodeSet.FunctionCode: AnyObject] = [:]
    
    override public var description: String {
        return "Accessory{uid='\(uid)', aid=\(aid), type=\(type), attributes=\(attributes)}"
    }
    
    init(uid: String, aid: Int, type: AccessoryTypeSet.AccessoryType) {
        self.uid = uid
        self.aid = aid
        self.type = type
    }
}
