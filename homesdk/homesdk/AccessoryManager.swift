//
//  AccessoryManager.swift
//  homesdk
//
//  Created by David Lin on 2/26/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class AccessoryManager: NSObject {
    public static let sharedInstance = AccessoryManager()
    
    public var accessories: [Key: Accessory] = [:]
    
    override public var description: String {
        var str = "AccessoryManager{"
        for (_, accessory) in accessories {
            str += "\(accessory)\n"
        }
        str += "}"
        return str
    }
    
    public class Key: Equatable, Hashable {
        public let uid: String
        public let aid: Int
        public let type: AccessoryTypeSet.AccessoryType
        
        public var hashValue: Int { return uid.hashValue + aid + type.hashValue }

        public init(uid: String, aid: Int, type: AccessoryTypeSet.AccessoryType) {
            self.uid = uid
            self.aid = aid
            self.type = type
        }
        
    }
}

public func ==(lhs: AccessoryManager.Key, rhs: AccessoryManager.Key) -> Bool {
    return lhs.uid == rhs.uid && lhs.aid == rhs.aid && lhs.type == rhs.type
}

