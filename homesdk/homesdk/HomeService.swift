//
//  HomeService.swift
//  homesdk
//
//  Created by David Lin on 2/26/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class HomeService: NSObject {
    let workerQueue: dispatch_queue_t
    let nc = NSNotificationCenter.defaultCenter()
        
    public override init() {
        Log.serviceLog("HomeService onCreate()")
        workerQueue = dispatch_queue_create("homeservice", nil)
    }
    
    public func doInitAsync() {
        dispatch_async(workerQueue) {
            Log.serviceLog("doInitAsync()")
            if DeviceManager.sharedInstance.isInited {
                Log.serviceLog("already inited")
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    DeviceManager.sharedInstance.isInited = true
                    self.nc.postNotificationName(EventReceiver.NOTIFY_INIT, object: nil)
                }
            }
        }
    }
    
    public func doSendCommandAsync() {
        dispatch_async(workerQueue) {
            Log.serviceLog("doSendCommandAsync()")
            if DeviceManager.sharedInstance.isInited {
                Log.serviceLog("allow send command!!")
                dispatch_async(dispatch_get_main_queue()) {
                    self.nc.postNotificationName(EventReceiver.NOTIFY_SEND_COMMAND, object: nil)
                }
            } else {
                Log.serviceLog("deny send command")
            }
        }
    }
    
    public func doAddDeviceAsync(uid: String, password: String) {
        dispatch_async(workerQueue) {
            Log.serviceLog("doAddDeviceAsync()")
            if DeviceManager.sharedInstance.isInited {
                Log.serviceLog("allow add device!!")
                let dev = try! AppConfig.deviceCreator.create(uid)
                let executor = RequestExecutor()
                if let session = dev.session {
                    session.addRequestExecutor(executor)
                    HomeLog.systemLog("uid: \(uid), password: \(password)")
                } else {
                    print("No device session")
                }
            } else {
                Log.serviceLog("deny add dvice")
            }
        }
    }
}
