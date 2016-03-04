//
//  RequestSet.swift
//  homesdk
//
//  Created by David Lin on 2/26/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class RequestSet: Request {
    internal var commands: [Request] = []
    
    public override var command: [NSData]? {
        get {
            var list: [NSData] = []
            for request in commands {
                if let tmp = request.command {
                    list.appendContentsOf(tmp)
                }
            }
            return list
        }
        
        set(value)  {
            // XXX(YC): no equivalent in Swift2 yet, cannot throw in computed property
            // so resolve to no-op for now
            /*
            throw NSError(domain: "HOMESDK", code: 4, userInfo: [NSLocalizedDescriptionKey: "setCommand(ICommand) method is invalid"])
            */
        }
    }
    
    public init() {
        super.init(command: [])
    }
    
    public func addRequests(requests: Request...) {
        commands.appendContentsOf(requests)
        responseCount = commands.count
        state = .INIT
    }
    
    
}
