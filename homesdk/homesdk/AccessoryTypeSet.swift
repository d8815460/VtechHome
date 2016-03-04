//
//  AccessoryTypeSet.swift
//  homesdk
//
//  Created by David Lin on 2/23/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

public class AccessoryTypeSet: NSObject {
    
    public static let UNKNOWN = AccessoryType(withValue: 0x00, andName: "UNKNOWN")
    public static let GATEWAY = AccessoryType(withValue: 0x3FF, andName: "GATEWAY")
    public static let LIGHT = AccessoryType(withValue: 0xFF, andName: "LIGHT")
    public static let PLUG = AccessoryType(withValue: 0xFE, andName: "PLUG")
    public static let IPCAM = AccessoryType(withValue: 0xFD, andName: "IPCAM")
    public static let DOOR_SENSOR = AccessoryType(withValue: 0xFC, andName: "DOOR_SENSOR")
    public static let SMOKE_SENSOR = AccessoryType(withValue: 0xFB, andName: "SMOKE_SENSOR")
    public static let WATERLEAK_SENSOR = AccessoryType(withValue: 0xFA, andName: "WATERLEAK_SENSOR")
    public static let PIR_SENSOR = AccessoryType(withValue: 0xF9, andName: "PIR_SENSOR")
    public static let GAS_SENSOR = AccessoryType(withValue: 0xF8, andName: "GAS_SENSOR")
    public static let VIBRATE_SENSOR = AccessoryType(withValue: 0xF7, andName: "VIBRATE_SENSOR")
    public static let IPCAMERA_SENSOR = AccessoryType(withValue: 0xF6, andName: "IPCAMERA_SENSOR")
    public static let LEAK_SENSOR = AccessoryType(withValue: 0xF5, andName: "LEAK_SENSOR")
    public static let AIR_CONDITIONER = AccessoryType(withValue: 0xF4, andName: "AIR_CONDITIONER")
    public static let SIREN_SENSOR = AccessoryType(withValue: 0xF3, andName: "SIREN_SENSOR")
    
    public func map(value: Int) -> AccessoryType {
        let allCodes: [AccessoryType] = [
            AccessoryTypeSet.GATEWAY,
            AccessoryTypeSet.LIGHT,
            AccessoryTypeSet.PLUG,
            AccessoryTypeSet.IPCAM,
            AccessoryTypeSet.DOOR_SENSOR,
            AccessoryTypeSet.SMOKE_SENSOR,
            AccessoryTypeSet.WATERLEAK_SENSOR,
            AccessoryTypeSet.PIR_SENSOR,
            AccessoryTypeSet.GAS_SENSOR,
            AccessoryTypeSet.VIBRATE_SENSOR,
            AccessoryTypeSet.IPCAMERA_SENSOR,
            AccessoryTypeSet.LEAK_SENSOR,
            AccessoryTypeSet.AIR_CONDITIONER,
            AccessoryTypeSet.SIREN_SENSOR];
        
        for code in allCodes {
            if code.value == value { return code }
        }
        return AccessoryTypeSet.UNKNOWN
    }
    
    public class AccessoryType: NSObject {
        public private(set) var value: NSInteger
        public private(set) var name: String
        
        override public var description: String {
            return "AccessoryType{value=\(value), name=\(name)}"
        }
        
        override public convenience init() {
            self.init(withValue: NSInteger.min, andName: "")
        }
        
        public init(withValue value: NSInteger, andName name: String) {
            self.value = value
            self.name = name
        }
    }
}

func ==(lhs: AccessoryTypeSet.AccessoryType, rhs: AccessoryTypeSet.AccessoryType) -> Bool {
    return lhs.value == rhs.value && lhs.name == rhs.name
}