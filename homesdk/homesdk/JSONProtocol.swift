//
//  JSONProtocol.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class JSONProtocol: IProtocol {

    private let dev: Device
    
    init(dev: Device) {
        self.dev = dev
    }
    
    public func buildGetProductCodeRequest(objs: AnyObject ...) throws -> [NSData]? {
        return nil
    }
    
    public func buildGetProductNameRequest(objs: AnyObject ...) throws -> [NSData]? {
        return nil
    }
    
    public func buildClientAuthenticationRequest(password: String, objs: AnyObject ...) throws -> [NSData]? {
        if objs.count != 1 {
            return []
        }
        let serno = Int(objs[0] as! NSNumber)
        
        let getAuth = CMDGetAuthentication(dev: dev)
        let args = getAuth.getArgs()
        args.serno = serno
        args.password = password
        return try getAuth.build(dev.channel, obj: args)
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
