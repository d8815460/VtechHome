//
//  Device.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public protocol Device_CREATOR {
    func create(uid: String) throws -> Device
}

public class Device: NSObject {
    var uid: String!
    var productName = ""
    var productCode = ProductCodeSet.UNKNOWN
    var auth = false
    var version: String? {
        get { return self.version }
        set(value) {
            if value != nil && self.version != value {
                self.version = value
                
                createProtocol()
                createChannel()
                
                channel.version = value!
            }
        }
    }
    var session: RDTSession?
    
    var protocol_: IProtocol!
    var channel: IChannel!
    var types: [Int] = []
    var connectionStatus: ConnectionStatus {
        return session!.connectionStatus
    }
    
    public override var description: String {
        return "Device{uid='\(uid)', productName='\(productName)', productCode=\(productCode), auth=\(auth), version='\(version)'"
    }
    
    public init(uid: String) {
        super.init()
        
        self.version = "1.0.0"
        self.uid = uid
        protocol_ = getDefaultProtocol()
        channel = getDefaultChannel()
        session = try! RDTSession(parent: self)
        
        let key = DeviceManager.Key(uid: uid)
        DeviceManager.sharedInstance.devices[key] = self
    }
    
    public convenience override init() {
        self.init(uid: "")
    }
    
    public func teardown() {
        guard let sess = session else { return }
        sess.teardown()
        session = nil
    }
    
    private func createProtocol() -> Bool {
        guard let ver = version else { return false }
        
        if ver == "1.0.0" || ver == "1.1.0" {
            protocol_ = ByteArrayProtocol(dev: self)
            return true
        }
        return false
    }
    
    private func createChannel() -> Bool {
        guard let ver = version else { return false }
        
        if ver == "1.0.0" || ver == "1.1.0" {
            channel = RDTv1Channel()
            return true
        }
        return false
    }
    
    func getDefaultProtocol() -> IProtocol {
        return ByteArrayProtocol(dev: self)
    }
    
    func getDefaultChannel() -> IChannel {
        return RDTv1Channel()
    }

    public func addRequestExecutor(executor: RequestExecutor) {
        session?.addRequestExecutor(executor)
    }
}
