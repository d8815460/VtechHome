//
//  HomeLog.swift
//  homesdk
//
//  Created by David Lin on 2/24/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

public class HomeLog {
    public class func systemLog(log: String) {
        print(log)
    }
    
    public class func customLog(tag: String, log: String) {
        print("\(tag): \(log)")
    }
}