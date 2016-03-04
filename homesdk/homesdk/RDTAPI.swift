//
//  RDTAPI.swift
//  homesdk
//
//  Created by David Lin on 2/25/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

public class RDTAPI {
    public enum StatusCode: Int32 {
        case UNKNOWN = -88888
        case NOERROR = 0
        case NOT_INITIALIZED = -10000
        case ALREADY_INITIALIZED = -10001
        case EXCEED_MAX_CHANNEL = -10002
        case MEM_INSUFF = -10003
        case FAIL_CREATE_THREAD = -10004
        case FAIL_CREATE_MUTEX = -10005
        case RDT_DESTROYED = -10006
        case TIMEOUT = -10007
        case INVALID_RDT_ID = -10008
        case RCV_DATA_END = -10009
        case REMOTE_ABORT = -10010
        case LOCAL_ABORT = -10011
        case CHANNEL_OCCUPIED = -10012
        case NO_PERMISSION = -10013
        case INVALID_ARG = -10014
        case LOCAL_EXIT = -10015
        case REMOTE_EXIT = -10016
    }
    
    public static let RDT_TIMEOUT_MS: Int32 = 2000
    
    public class func getVersion() -> String {
        let ver = RDT_GetRDTApiVer()
        var parts = [
            UInt8((ver >> 24) & 0xFF),
            UInt8((ver >> 16) & 0xFF),
            UInt8((ver >> 8) & 0xFF),
            UInt8((ver >> 0) & 0xFF)
        ]
        return "\(parts[0]).\(parts[1]).\(parts[2]).\(parts[3])"
    }
    
    public class func bootstrap() -> Bool {
        let result = StatusCode(rawValue: RDT_Initialize())!
        HomeLog.systemLog("init rdtResult: \(result)")
        if result.rawValue > StatusCode.NOERROR.rawValue ||
            result == StatusCode.ALREADY_INITIALIZED {
            return true
        }
        Log.rdtAPILog("RDT_Initialize() return negative value: \(result.rawValue)")
        return false
    }
    
    public class func connect(sessionId: Int32) -> Int32 {
        let channelID = RDT_Create(sessionId, 2000, 0)
        if channelID < StatusCode.NOERROR.rawValue {
            Log.rdtAPILog("RDT_Create(sessionID, timeout, channelID) return negative value: \(channelID)")
        }
        return channelID
    }
    
    public class func sendData(channelId: Int32, data: NSData) -> Int32 {
        let buf = data.bytes
        let result = RDT_Write(channelId, UnsafePointer(buf), Int32(data.length))
        if result < StatusCode.NOERROR.rawValue {
            Log.rdtAPILog("RDT_Write(channelId, data, data.length) return negative value: \(result)")
        }
        return result
    }
    
    public class func readData(channelId: Int32, data: NSMutableData) -> Int32 {
        let result = RDT_Read(channelId, UnsafeMutablePointer(data.bytes), Int32(data.length), RDTAPI.RDT_TIMEOUT_MS)
        if result < StatusCode.NOERROR.rawValue {
            Log.rdtAPILog("RDT_Read(channelId, data, data.length, timeout) return negative value: \(result)")
        }
        return result
    }
    
    public class func destroy(channelId: Int32) -> Bool {
        let result = RDT_Destroy(channelId)
        if result >= StatusCode.NOERROR.rawValue {
            return true
        }
        Log.rdtAPILog("RDT_Destroy(channelId) return negative value:  \(result)")
        return false
    }
    
    public class func teardown() -> StatusCode {
        return StatusCode(rawValue: RDT_DeInitialize())!
    }

}
