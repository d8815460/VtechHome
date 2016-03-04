//
//  IChannel.swift
//  homesdk
//
//  Created by David Lin on 2/24/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

public protocol IChannel {
    var version: String { get set }
    func concatChannelInfo(content: NSData?, _ objs: AnyObject ...) throws -> [NSData]
    func segment(buf: NSData) throws -> [NSData]
    func checkVersionInitialization() throws
    func compareVersion(version: String) -> Bool
}