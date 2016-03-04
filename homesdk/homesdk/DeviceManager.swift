//
//  DeviceManager.swift
//  homesdk
//
//  Created by David Lin on 2/26/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class DeviceManager: NSObject {
    public static let sharedInstance = DeviceManager()
    
    public var isInited = false
    public var devices: [Key: Device] = [:]
    
    public override var description: String {
        var str = "DeviceManager{"
        for (_, device) in devices { str += "\(device)\n" }
        str += "}"
        return str
    }
    
    public func teardown() {
        HomeLog.systemLog("teardown start devicemanager size: \(devices.count)")
        isInited = false
        for (_, device) in devices { device.teardown() }
        devices.removeAll()
        
        let rdtResult = RDTAPI.teardown()
        HomeLog.systemLog("teardown rdtResult: \(rdtResult)")
        let iotcResult = IOTCAPI.teardown()
        HomeLog.systemLog("teardown iotcResult: \(iotcResult)")
        HomeLog.systemLog("teardown end devicemanager size: \(devices.count)")
    }
    
    public class Key: Equatable, Hashable {
        public let uid: String
        
        init(uid: String) { self.uid = uid }
        
        public var hashValue: Int { return uid.hashValue }
    }
}

public func ==(lhs: DeviceManager.Key, rhs: DeviceManager.Key) -> Bool {
    return lhs.uid == rhs.uid
}
