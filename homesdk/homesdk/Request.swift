//
//  Request.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class Request {
    public enum State {
        case UNDEFINED
        case INIT
        case SEND_SUCCESS
        case SEND_FAIL
        case RESPONSE_SUCCESS
        case REPORT_SUCCESS
    }
    
    public var state: State = .UNDEFINED
    public var command: [NSData]? {
        get {
            return self.command
        }
        set(value) {
            self.command = value
            state = self.command == nil ? .UNDEFINED : .INIT
        }
    }
    public internal(set) var responseCount = 1
    
    convenience init() {
        self.init(command: nil)
    }
    
    init(command: [NSData]?) {
        self.command = command
    }
    
    public func decreaseResponseCount() {
        responseCount--
    }
    
    public func onPreExecute(dev: Device) {
        // intentially no-op. Subclass should override
    }
    
    public func onParseResponseCompleted(dev: Device) {
        // intentially no-op. Subclass should override
    }
}
