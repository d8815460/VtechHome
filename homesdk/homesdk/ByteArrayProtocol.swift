//
//  ByteArrayProtocol.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class ByteArrayProtocol: IProtocol {
    private let dev: Device
    
    init(dev: Device) { self.dev = dev }
    
    public func buildGetProductCodeRequest(objs: AnyObject ...) throws -> [NSData]? {
        return nil
    }
    
    public func buildGetProductNameRequest(objs: AnyObject ...) throws -> [NSData]? {
        return nil
    }
    
    public func buildClientAuthenticationRequest(password: String, objs: AnyObject ...) throws -> [NSData]? {
        return nil
    }
    
    public func buildGetAllTypesRequest(objs: AnyObject ...) throws -> [NSData]? {
        return nil
    }
    
    public func buildGetAccessoriesRequst(type: Int, objs: AnyObject ...) throws -> [NSData]? {
        return nil
    }
    
    public func buildGetVersionRequest(objs: AnyObject ...) throws -> [NSData]? {
        return nil
    }
    
    public func parseCommand(command: NSData) -> Int {
        return 0
    }
}
