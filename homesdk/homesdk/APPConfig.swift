//
//  AppConfig.swift
//  homesdk
//
//  Created by David Lin on 2/23/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

public class AppConfig: NSObject {
    
    public static var productCodeSet = ProductCodeSet()
    public static var accessoryTypeSet = AccessoryTypeSet()
    public static var v1FunctionCodeSet = V1FunctionCodeSet()
    public static var v2FunctionCodeSet = V2FunctionCodeSet()

    public class MyDeviceCreator: Device_CREATOR {
        public func create(uid: String) throws -> Device {
            return Device(uid: uid)
        }
    }

    public static var deviceCreator = MyDeviceCreator()
    
    public class MyAccessoryCreator: Accessory_CREATOR {
        public func create(uid: String, aid: Int, type: AccessoryTypeSet.AccessoryType) -> Accessory {
            return Accessory(uid: uid, aid: aid, type: type)
        }
    }
    
    public static var accessoryCreator = MyAccessoryCreator()
}