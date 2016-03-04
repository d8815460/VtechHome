//
//  IProtocol.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public protocol IProtocol {
    func buildGetProductCodeRequest(objs: AnyObject ...) throws -> [NSData]?
    func buildGetProductNameRequest(objs: AnyObject ...) throws -> [NSData]?
    func buildClientAuthenticationRequest(password: String, objs: AnyObject ...) throws -> [NSData]?
    func buildGetAllTypesRequest(objs: AnyObject ...) throws -> [NSData]?
    func buildGetAccessoriesRequst(type: Int, objs: AnyObject ...) throws -> [NSData]?
    func buildGetVersionRequest(objs: AnyObject ...) throws -> [NSData]?
    func parseCommand(command: NSData) -> Int
}
