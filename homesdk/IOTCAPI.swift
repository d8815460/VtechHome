//
//  IOTCAPI.swift
//  homesdk
//
//  Created by David Lin on 2/24/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

public class IOTCAPI {
    public enum StatusCode: Int32 {
        case UNKNOWN = -88888
        case NOERROR = 0
        case SERVER_NOT_RESPONSE = -1
        case FAIL_RESOLVE_HOSTNAME = -2
        case ALREADY_INITIALIZED = -3
        case FAIL_CREATE_MUTEX = -4
        case FAIL_CREATE_THREAD = -5
        case FAIL_CREATE_SOCKET = -6
        case FAIL_SOCKET_OPT = -7
        case FAIL_SOCKET_BIND = -8
        case UNLICENSE = -10
        case LOGIN_ALREADY_CALLED = -11
        case NOT_INITIALIZED = -12
        case TIMEOUT = -13
        case INVALID_SID = -14
        case UNKNOWN_DEVICE = -15
        case FAIL_GET_LOCAL_IP = -16
        case LISTEN_ALREADY_CALLED = -17
        case EXCEED_MAX_SESSION = -18
        case CAN_NOT_FIND_DEVICE = -19
        case CONNECT_IS_CALLING = -20
        case SESSION_CLOSE_BY_REMOTE = -22
        case REMOTE_TIMEOUT_DISCONNECT = -23
        case DEVICE_NOT_LISTENING = -24
        case CH_NOT_ON = -26
        case FAIL_CONNECT_SEARCH = -27
        case MASTER_TOO_FEW = -28
        case AES_CERTIFY_FAIL = -29
        case SESSION_NO_FREE_CHANNEL = -31
        case TCP_TRAVEL_FAILED = -32
        case TCP_CONNECT_TO_SERVER_FAILED = -33
        case CLIENT_NOT_SECURE_MODE = -34
        case CLIENT_SECURE_MODE = -35
        case DEVICE_NOT_SECURE_MODE = -36
        case DEVICE_SECURE_MODE = -37
        case INVALID_MODE = -38
        case EXIT_LISTEN = -39
        case NO_PERMISSION = -40
        case NETWORK_UNREACHABLE = -41
        case FAIL_SETUP_RELAY = -42
        case NOT_SUPPORT_RELAY = -43
        case NO_SERVER_LIST = -44
        case DEVICE_MULTI_LOGIN = -45
        case INVALID_ARG = -46
        case NOT_SUPPORT_PE = -47
        case DEVICE_EXCEED_MAX_SESSION = -48
        case BLOCKED_CALL = -49
        case SESSION_CLOSED = -50
        case REMOTE_NOT_SUPPORTED = -51
        case ABORTED = -52
        case EXCEED_MAX_PACKET_SIZE = -53
        case SERVER_NOT_SUPPORT = -54
        case NO_PATH_TO_WRITE_DATA = -55
        case SERVICE_IS_NOT_STARTED = -56
        case STILL_IN_PROCESSING = -57
        case NOT_ENOUGH_MEMORY = -58
        case DEVICE_IS_BANNED = -59
        case MASTER_NOT_RESPONSE = -60
        case DEVICE_OFFLINE = -90
    }
    
    public class func getVersion() -> String {
        var ver: UInt32 = 0
        
        IOTC_Get_Version(&ver)
        var parts = [
            UInt8((ver >> 24) & 0xFF),
            UInt8((ver >> 16) & 0xFF),
            UInt8((ver >> 8) & 0xFF),
            UInt8((ver >> 0) & 0xFF)
            ]
        return "\(parts[0]).\(parts[1]).\(parts[2]).\(parts[3])"
    }
    
    public class func bootstrap() -> Bool {
        let udpPort: UInt16 = 10000 + (UInt16(NSDate().timeIntervalSince1970 * 1000) % 10000)
        let iotcResult = StatusCode(rawValue: IOTC_Initialize2(udpPort))!
        HomeLog.systemLog("init iotcResult: \(iotcResult)")
        switch iotcResult {
        case .NOERROR: fallthrough
        case .ALREADY_INITIALIZED:
            return true
        default:
            Log.iotcAPILog("IOTC_Initialize2(udpPort) return negative value: \(iotcResult.rawValue)")
            return false
        }
    }
    
    public class func getSessionId() -> Int32 {
        let sessionId = IOTC_Get_SessionID()
        if sessionId < 0 {
            Log.iotcAPILog("IOTC_Get_SessionID() return negative value: \(sessionId)")
        }
        return sessionId
    }
    
    public class func connectByUIDParallel(uid: String, sessionId: Int32) -> Int32 {
        let data = uid.dataUsingEncoding(NSUTF8StringEncoding)!
        let sessionId2 = IOTC_Connect_ByUID_Parallel(UnsafePointer(data.bytes), sessionId)
        if sessionId2 < 0 {
            Log.iotcAPILog("IOTC_Connect_ByUID_Parallel(uid, sessionId) return negative value: \(sessionId2)")
        }
        return sessionId2
    }
    
    public class func teardown() -> StatusCode {
        return StatusCode(rawValue: IOTC_DeInitialize())!
    }
}