//
//  RequestExecutor.swift
//  homesdk
//
//  Created by David Lin on 2/26/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class RequestExecutor: NSObject {
    private var requests: [Request] = []
    private var progress = 0
    
    public var currentRequest: Request {
        return requests[progress]
    }
    
    public var isExecuteComplete: Bool {
        return progress == requests.count
    }
    
    public func addRequests(requests: Request...) {
        self.requests.appendContentsOf(requests)
    }
    
    public func increaseProgress() { progress++ }

    public override init() {}
    
    public func onPostExecute(dev: Device) {
        
    }
}
