//
//  CommandTool.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class CommandTool {
    public static let BUNDLE_NAME_UID = "uid"
    public static let BUNDLE_NAME_PASSWORD = "password"
    
    public class func genAddDeviceArgs(uid: String, password: String) -> [String: AnyObject] {
        return [
            BUNDLE_NAME_UID: uid,
            BUNDLE_NAME_PASSWORD: password
        ]
    }
}
