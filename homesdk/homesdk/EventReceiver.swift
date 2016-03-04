//
//  EventReceiver.swift
//  homesdk
//
//  Created by David Lin on 2/26/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class EventReceiver: NSObject {
    public static let NOTIFY_INIT = "com.tutk.homesdk.eventreceiver.action.init"
    public static let NOTIFY_SEND_COMMAND = "com.tutk.homesdk.eventreceiver.action.sendCommand"
    
    public override init() {
        super.init()
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "notifyInit:", name: EventReceiver.NOTIFY_INIT, object: nil)
        nc.addObserver(self, selector: "notifySendCommand:", name: EventReceiver.NOTIFY_SEND_COMMAND, object: nil)
    }
    
    public func notifyInit(notif: NSNotification) {
        
    }
    
    public func notifySendCommand(notif: NSNotification) {
        
    }
}
