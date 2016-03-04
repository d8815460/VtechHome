//
//  Log.swift
//  homesdk
//
//  Created by David Lin on 2/24/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

public class Log {
    public class func deviceManagerLog(log: String) {
        print("DEVICEMANAGER: \(log)")
    }
    
    public class func serviceLog(log: String) {
        print("HOMESERVBICE: \(log)")
    }
    
    public class func deviceSessionLog(uid: String, log: String) {
        print("DEVICESESSION: Device Session: \(uid), \(log)")
    }
    
    public class func deviceLog(uid: String, log: String) {
        print("DEVICE: Device: \(uid), \(log)")
    }
    
    public class func accessoryLog(uid: String, aid: Int, type: AccessoryTypeSet.AccessoryType, log: String) {
        print("ACCESSORY: Accessory: \(uid), \(aid), \(type), \(log)")
    }
    
    public class func rdtAPILog(log: String) {
        print("RDTAPI: \(log)")
    }
    
    public class func iotcAPILog(log: String) {
        print("IOTCAPI: \(log)")
    }
}