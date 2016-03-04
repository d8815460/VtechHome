//
//  HomeAPI.swift
//  homesdk
//
//  Created by David Lin on 2/26/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class HomeAPI: NSObject {
    public static func genAddAdeviceRequestList(dev: Device, password: String) -> RequestExecutor {
        class MyExecutor: RequestExecutor {
            override func onPostExecute(dev: Device) {
                super.onPostExecute(dev)
                HomeLog.systemLog(AccessoryManager.sharedInstance.description)
                HomeLog.systemLog(DeviceManager.sharedInstance.description)
            }
        }
        let executor = MyExecutor()
        let cmd29 = try! Request(command: dev.protocol_.buildGetVersionRequest())
        executor.addRequests(cmd29)

        class RequestSet_2_3_7: RequestSet {
            let password: String
            override func onPreExecute(dev: Device) {
                super.onPreExecute(dev)
                let cmd2 = try! Request(command: dev.protocol_.buildGetProductCodeRequest())
                let cmd3 = try! Request(command: dev.protocol_.buildGetProductNameRequest())
                let cmd7 = try! Request(command: dev.protocol_.buildClientAuthenticationRequest(password))
                commands.appendContentsOf([cmd2, cmd3, cmd7])
            }
            
            init(password: String) { self.password = password }
        }
        let cmd_2_3_7 = RequestSet_2_3_7(password: password)
        executor.addRequests(cmd_2_3_7)
        
        class Request_17: Request {
            private override func onPreExecute(dev: Device) {
                super.onPreExecute(dev)
                command = try! dev.protocol_.buildGetAllTypesRequest()
            }
            
            private override func onParseResponseCompleted(dev: Device) {
                super.onParseResponseCompleted(dev)
                var keysToRemove: [AccessoryManager.Key] = []
                for (key, _) in AccessoryManager.sharedInstance.accessories {
                    keysToRemove.append(key)
                }
                
                for key in keysToRemove {
                    AccessoryManager.sharedInstance.accessories.removeValueForKey(key)
                }
            }
        }
        let cmd17 = Request_17()
        executor.addRequests(cmd17)
        
        class Request24s: RequestSet {
            private override func onPreExecute(dev: Device) {
                super.onPreExecute(dev)
                let types = dev.types
                for type in types {
                    let cmd24 = try! Request(command: dev.protocol_.buildGetAccessoriesRequst(type))
                    addRequests(cmd24)
                }
            }
        }
        let cmd24s = Request24s()
        executor.addRequests(cmd24s)

        return executor
    }
}
