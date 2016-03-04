//
//  ConnectionStatus.swift
//  homesdk
//
//  Created by David Lin on 2/27/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import UIKit

public enum ConnectionStatus: Int {
    case ERROR_TRANSFER_FAIL = -3
    case ERROR_CONNECTION_FAIL = -2
    case ERROR_INIT_FAIL = -1
    case DISCONNECTED = 0
    case CONNECTING = 1
    case CONNECTED = 2
}
