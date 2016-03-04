//
//  RDTSession.swift
//  homesdk
//
//  Created by David Lin on 2/27/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public class RDTSession: NSObject {
    private var sessionID: Int32 = -1
    private var channelID: Int32 = -1
    private var reader: ReadWorker?
    private var writer: WriteWorker?
    private var queue: RequestQueue?
    private var dev: Device
    public private(set) var connectionStatus: ConnectionStatus {
        get { return self.connectionStatus }
        set(value) {
            self.connectionStatus = value
            HomeLog.systemLog("\(value)")
        }
    }
    
    private class ReadWorker {
        private static let BUFF_SIZE = 1280
        private let parent: RDTSession
        private var isRunning = true
        
        let workerQueue: dispatch_queue_t
        
        init(parent: RDTSession) {
            self.parent = parent
            workerQueue = dispatch_queue_create("rdtsession.readworker.\(self.parent.dev.uid)", nil)
        }
        
        func stop() {
            isRunning = false
        }
        
        func start() {
            dispatch_async(workerQueue) {
                let rdtSession = self.parent
                let device = rdtSession.dev
                
                let buff = NSMutableData(capacity: ReadWorker.BUFF_SIZE)!
                while self.isRunning {
                    let dataLen: Int32 = RDTAPI.readData(rdtSession.channelID, data: buff)
                    
                    if dataLen < 0 && dataLen != RDTAPI.StatusCode.TIMEOUT.rawValue {
                        rdtSession.connectionStatus = .DISCONNECTED
                        rdtSession.reconnect()
                    }
                    
                    if dataLen <= 0 { continue; } // early return
                    
                    if rdtSession.connectionStatus != .CONNECTED {
                        rdtSession.connectionStatus = .CONNECTED
                    }
                    
                    Log.deviceSessionLog(device.uid, log: "received: \(buff.hexString)")
                    
                    let cmdList = try! device.channel.segment(buff)
                    for cmd in cmdList {
                        device.protocol_.parseCommand(cmd)
                        let executor = rdtSession.queue!.getFirst() // might block
                        let request = executor.currentRequest
                        if request.state == .SEND_SUCCESS {
                            request.responseCount--
                            if request.responseCount == 0 {
                                executor.increaseProgress()
                                if executor.isExecuteComplete {
                                    executor.onPostExecute(device)
                                    rdtSession.queue!.removeFirst()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    private class WriteWorker {
        private let workerQueue: dispatch_queue_t
        private let parent: RDTSession
        private var isRunning = true
        
        init(parent: RDTSession) {
            self.parent = parent
            workerQueue = dispatch_queue_create("rdtsession.writeworker.\(parent.dev.uid)", nil)
        }
        
        func stop() {
            isRunning = false
        }
        
        func start() {
            dispatch_async(workerQueue) {
                let rdtSession = self.parent
                let device = rdtSession.dev
                
                while self.isRunning {
                    let executor = rdtSession.queue!.getFirst()
                    if executor.isExecuteComplete { continue } // early return
                    var request: Request!
                    request = executor.currentRequest
                    if request.state == .UNDEFINED {
                        request.onPreExecute(device)
                    }
                    if request.state == .INIT {
                        let cmdsOpt = request.command
                        let cmds = cmdsOpt!
                        if cmds.count == 0 {
                            request.state = .SEND_FAIL
                            rdtSession.queue!.removeFirst()
                        } else {
                            for cmd in cmds {
                                let result = RDTAPI.sendData(rdtSession.channelID, data: cmd)
                                if result >= RDTAPI.StatusCode.NOERROR.rawValue {
                                    request.state = .SEND_SUCCESS
                                } else {
                                    rdtSession.connectionStatus = .ERROR_TRANSFER_FAIL
                                    request.state = .SEND_FAIL
                                    rdtSession.queue!.removeFirst()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    class RequestQueue {
        private var executors: [RequestExecutor] = []
        private var semaphore: dispatch_semaphore_t
        init() {
            semaphore = dispatch_semaphore_create(0) // initially no items in queue
        }
        
        func removeFirst() -> RequestExecutor {
            while executors.isEmpty {
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            }
            return executors.removeFirst()
        }
        
        func getFirst() -> RequestExecutor {
            while executors.isEmpty {
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            }
            let executor = executors.first!
            dispatch_semaphore_signal(semaphore) // since semantic of get first does not change the number of executors, we need to add back the count
            return executor
        }
        
        func put(executor: RequestExecutor) {
            executors.append(executor)
            dispatch_semaphore_signal(semaphore)
        }
        
        func clear() {
            executors.removeAll()
            semaphore = dispatch_semaphore_create(0) // reset semaphore to 0
        }
    }
    
    public init(parent: Device) throws {
        self.dev = parent
        super.init()
        
        connect(self.dev.uid)
        initSession()
    }
    
    private func initSession() {
        queue = RequestQueue()
        
        writer = WriteWorker(parent: self)
        writer!.start()
        
        reader = ReadWorker(parent: self)
        reader!.start()
    }
    
    private func bootstrap() -> Bool {
        let iotcResult = IOTCAPI.bootstrap()
        if !iotcResult { return false }
        let rdtResult = RDTAPI.bootstrap()
        return rdtResult
    }
    
    public func connect(uid: String) -> Bool {
        let initResult = bootstrap()
        if initResult {
            sessionID = IOTCAPI.getSessionId()
            if sessionID < 0 {
                connectionStatus = .ERROR_INIT_FAIL
                return false
            }
            
            sessionID = IOTCAPI.connectByUIDParallel(uid, sessionId: sessionID)
            if sessionID < 0 {
                connectionStatus = .ERROR_CONNECTION_FAIL
                return false
            }
            
            channelID = RDTAPI.connect(sessionID)
            if channelID < RDTAPI.StatusCode.NOERROR.rawValue {
                connectionStatus = .ERROR_CONNECTION_FAIL
                return false
            }
            
            connectionStatus = .CONNECTED
            Log.deviceSessionLog(uid, log: "sessionID: \(sessionID)")
            Log.deviceSessionLog(uid, log: "channelID: \(channelID)")
            return true
        } else {
            connectionStatus = .ERROR_INIT_FAIL
            return false
        }
    }
    
    public func reconnect() {
        disconnect()
        connect(dev.uid)
        initSession()
    }
    
    public func disconnect() {
        if writer != nil {
            writer!.stop()
            writer = nil
        }
        
        if reader != nil {
            reader!.stop()
            reader = nil
        }
        
        if queue != nil {
            queue!.clear()
            queue = nil
        }
    }
    
    public func teardown() -> Bool {
        return RDTAPI.destroy(channelID)
    }

    public func addRequestExecutor(executor: RequestExecutor) {
        queue!.put(executor)
    }
}
