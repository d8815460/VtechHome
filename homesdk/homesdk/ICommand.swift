//
//  ICommand.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public protocol ICommand {
    func build(channel: IChannel, obj: AnyObject) throws -> [NSData]
    func parse(content: NSData) -> Bool
}
