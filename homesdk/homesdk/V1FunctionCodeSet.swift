//
//  V1FunctionCodeSet.swift
//  homesdk
//
//  Created by David Lin on 2/23/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation


public class V1FunctionCodeSet: NSObject {
    
    public static let UNKNOWN = FunctionCode();
    public static let PLUG_SWITCH = FunctionCode(withType: AccessoryTypeSet.PLUG, value: 1, nameForDebug: "PLUG_SWITCH", andParser: DataParser.BOOLEAN)
    public static let PLUG_WATT = FunctionCode(withType: AccessoryTypeSet.PLUG, value: 3, nameForDebug: "PLUG_WATT", andParser: DataParser.FLOAT);
    public static let PLUG_AMPERE = FunctionCode(withType: AccessoryTypeSet.PLUG, value: 5, nameForDebug: "PLUG_AMPERE", andParser: DataParser.FLOAT);
    public static let PLUG_VOLT = FunctionCode(withType: AccessoryTypeSet.PLUG, value: 7, nameForDebug: "PLUG_VOLT", andParser: DataParser.FLOAT);
    public static let PLUG_NAME = FunctionCode(withType: AccessoryTypeSet.PLUG, value: 253, nameForDebug: "PLUG_NAME", andParser: DataParser.STRING);
    public static let LIGHT_SWITCH = FunctionCode(withType: AccessoryTypeSet.LIGHT, value: 1, nameForDebug: "LIGHT_SWITCH", andParser: DataParser.BOOLEAN);
    public static let LIGHT_BRIGHTNESS = FunctionCode(withType: AccessoryTypeSet.LIGHT, value: 3, nameForDebug: "LIGHT_BRIGHTNESS", andParser: DataParser.INTEGER);
    public static let LIGHT_COLOR = FunctionCode(withType: AccessoryTypeSet.LIGHT, value: 5, nameForDebug: "LIGHT_COLOR", andParser: DataParser.INTEGER);
    public static let LIGHT_HUE = FunctionCode(withType: AccessoryTypeSet.LIGHT, value: 9, nameForDebug: "LIGHT_HUE", andParser: DataParser.INTEGER);
    public static let LIGHT_SATURATION = FunctionCode(withType: AccessoryTypeSet.LIGHT, value: 11, nameForDebug: "LIGHT_SATURATION", andParser: DataParser.INTEGER);
    public static let LIGHT_COLOR_TEMPERATURE = FunctionCode(withType: AccessoryTypeSet.LIGHT, value: 13, nameForDebug: "LIGHT_COLOR_TEMPERATURE", andParser: DataParser.INTEGER);
    public static let LIGHT_NAME = FunctionCode(withType: AccessoryTypeSet.LIGHT, value: 253, nameForDebug: "LIGHT_NAME", andParser: DataParser.STRING);
    public static let DOOR_SWITCH = FunctionCode(withType: AccessoryTypeSet.DOOR_SENSOR, value: 1, nameForDebug: "DOOR_SWITCH", andParser: DataParser.BOOLEAN);
    public static let DOOR_CONNECTION = FunctionCode(withType: AccessoryTypeSet.DOOR_SENSOR, value: 3, nameForDebug: "DOOR_CONNECTION", andParser: DataParser.BOOLEAN);
    public static let DOOR_TRIGGER = FunctionCode(withType: AccessoryTypeSet.DOOR_SENSOR, value: 5, nameForDebug: "DOOR_TRIGGER", andParser: DataParser.BOOLEAN);
    public static let DOOR_ALARM = FunctionCode(withType: AccessoryTypeSet.DOOR_SENSOR, value: 7, nameForDebug: "DOOR_ALARM", andParser: DataParser.BOOLEAN);
    public static let DOOR_SOS = FunctionCode(withType: AccessoryTypeSet.DOOR_SENSOR, value: 9, nameForDebug: "DOOR_SOS", andParser: DataParser.BOOLEAN);
    public static let DOOR_POWER = FunctionCode(withType: AccessoryTypeSet.DOOR_SENSOR, value: 11, nameForDebug: "DOOR_POWER", andParser: DataParser.INTEGER);
    public static let DOOR_NAME = FunctionCode(withType: AccessoryTypeSet.DOOR_SENSOR, value: 253, nameForDebug: "DOOR_NAME", andParser: DataParser.STRING);
    public static let WATERLEAK_SWITCH = FunctionCode(withType: AccessoryTypeSet.WATERLEAK_SENSOR, value: 1, nameForDebug: "WATERLEAK_SWITCH", andParser: DataParser.BOOLEAN);
    public static let WATERLEAK_CONNECTION = FunctionCode(withType: AccessoryTypeSet.WATERLEAK_SENSOR, value: 3, nameForDebug: "WATERLEAK_CONNECTION", andParser: DataParser.BOOLEAN);
    public static let WATERLEAK_TRIGGER = FunctionCode(withType: AccessoryTypeSet.WATERLEAK_SENSOR, value: 5, nameForDebug: "WATERLEAK_TRIGGER", andParser: DataParser.BOOLEAN);
    public static let WATERLEAK_ALARM = FunctionCode(withType: AccessoryTypeSet.WATERLEAK_SENSOR, value: 7, nameForDebug: "WATERLEAK_ALARM", andParser: DataParser.BOOLEAN);
    public static let WATERLEAK_SOS = FunctionCode(withType: AccessoryTypeSet.WATERLEAK_SENSOR, value: 9, nameForDebug: "WATERLEAK_SOS", andParser: DataParser.BOOLEAN);
    public static let WATERLEAK_POWER = FunctionCode(withType: AccessoryTypeSet.WATERLEAK_SENSOR, value: 11, nameForDebug: "WATERLEAK_POWER", andParser: DataParser.INTEGER);
    public static let WATERLEAK_NAME = FunctionCode(withType: AccessoryTypeSet.WATERLEAK_SENSOR, value: 253, nameForDebug: "WATERLEAK_NAME", andParser: DataParser.STRING);
    public static let PIR_SWITCH = FunctionCode(withType: AccessoryTypeSet.PIR_SENSOR, value: 1, nameForDebug: "PIR_SWITCH", andParser: DataParser.BOOLEAN);
    public static let PIR_CONNECTION = FunctionCode(withType: AccessoryTypeSet.PIR_SENSOR, value: 3, nameForDebug: "PIR_CONNECTION", andParser: DataParser.BOOLEAN);
    public static let PIR_TRIGGER = FunctionCode(withType: AccessoryTypeSet.PIR_SENSOR, value: 5, nameForDebug: "PIR_TRIGGER", andParser: DataParser.BOOLEAN);
    public static let PIR_ALARM = FunctionCode(withType: AccessoryTypeSet.PIR_SENSOR, value: 7, nameForDebug: "PIR_ALARM", andParser: DataParser.BOOLEAN);
    public static let PIR_SOS = FunctionCode(withType: AccessoryTypeSet.PIR_SENSOR, value: 9, nameForDebug: "PIR_SOS", andParser: DataParser.BOOLEAN);
    public static let PIR_POWER = FunctionCode(withType: AccessoryTypeSet.PIR_SENSOR, value: 11, nameForDebug: "PIR_POWER", andParser: DataParser.INTEGER);
    public static let PIR_NAME = FunctionCode(withType: AccessoryTypeSet.PIR_SENSOR, value: 253, nameForDebug: "PIR_NAME", andParser: DataParser.STRING);
    public static let SMOKE_SWITCH = FunctionCode(withType: AccessoryTypeSet.SMOKE_SENSOR, value: 1, nameForDebug: "SMOKE_SWITCH", andParser: DataParser.BOOLEAN);
    public static let SMOKE_CONNECTION = FunctionCode(withType: AccessoryTypeSet.SMOKE_SENSOR, value: 3, nameForDebug: "SMOKE_CONNECTION", andParser: DataParser.BOOLEAN);
    public static let SMOKE_TRIGGER = FunctionCode(withType: AccessoryTypeSet.SMOKE_SENSOR, value: 5, nameForDebug: "SMOKE_TRIGGER", andParser: DataParser.BOOLEAN);
    public static let SMOKE_ALARM = FunctionCode(withType: AccessoryTypeSet.SMOKE_SENSOR, value: 7, nameForDebug: "SMOKE_ALARM", andParser: DataParser.BOOLEAN);
    public static let SMOKE_SOS = FunctionCode(withType: AccessoryTypeSet.SMOKE_SENSOR, value: 9, nameForDebug: "SMOKE_SOS", andParser: DataParser.BOOLEAN);
    public static let SMOKE_POWER = FunctionCode(withType: AccessoryTypeSet.SMOKE_SENSOR, value: 11, nameForDebug: "SMOKE_POWER", andParser: DataParser.INTEGER);
    public static let SMOKE_NAME = FunctionCode(withType: AccessoryTypeSet.SMOKE_SENSOR, value: 253, nameForDebug: "SMOKE_NAME", andParser: DataParser.STRING);
    public static let LEAK_SWITCH = FunctionCode(withType: AccessoryTypeSet.LEAK_SENSOR, value: 1, nameForDebug: "LEAK_SWITCH", andParser: DataParser.BOOLEAN);
    public static let LEAK_CONNECTION = FunctionCode(withType: AccessoryTypeSet.LEAK_SENSOR, value: 3, nameForDebug: "LEAK_CONNECTION", andParser: DataParser.BOOLEAN);
    public static let LEAK_TRIGGER = FunctionCode(withType: AccessoryTypeSet.LEAK_SENSOR, value: 5, nameForDebug: "LEAK_TRIGGER", andParser: DataParser.BOOLEAN);
    public static let LEAK_ALARM = FunctionCode(withType: AccessoryTypeSet.LEAK_SENSOR, value: 7, nameForDebug: "LEAK_ALARM", andParser: DataParser.BOOLEAN);
    public static let LEAK_SOS = FunctionCode(withType: AccessoryTypeSet.LEAK_SENSOR, value: 9, nameForDebug: "LEAK_SOS", andParser: DataParser.BOOLEAN);
    public static let LEAK_POWER = FunctionCode(withType: AccessoryTypeSet.LEAK_SENSOR, value: 11, nameForDebug: "LEAK_POWER", andParser: DataParser.INTEGER);
    public static let LEAK_NAME = FunctionCode(withType: AccessoryTypeSet.LEAK_SENSOR, value: 253, nameForDebug: "LEAK_NAME", andParser: DataParser.STRING);
    public static let GAS_SWITCH = FunctionCode(withType: AccessoryTypeSet.GAS_SENSOR, value: 1, nameForDebug: "GAS_SWITCH", andParser: DataParser.BOOLEAN);
    public static let GAS_CONNECTION = FunctionCode(withType: AccessoryTypeSet.GAS_SENSOR, value: 3, nameForDebug: "GAS_CONNECTION", andParser: DataParser.BOOLEAN);
    public static let GAS_TRIGGER = FunctionCode(withType: AccessoryTypeSet.GAS_SENSOR, value: 5, nameForDebug: "GAS_TRIGGER", andParser: DataParser.BOOLEAN);
    public static let GAS_ALARM = FunctionCode(withType: AccessoryTypeSet.GAS_SENSOR, value: 7, nameForDebug: "GAS_ALARM", andParser: DataParser.BOOLEAN);
    public static let GAS_SOS = FunctionCode(withType: AccessoryTypeSet.GAS_SENSOR, value: 9, nameForDebug: "GAS_SOS", andParser: DataParser.BOOLEAN);
    public static let GAS_POWER = FunctionCode(withType: AccessoryTypeSet.GAS_SENSOR, value: 11, nameForDebug: "GAS_POWER", andParser: DataParser.INTEGER);
    public static let GAS_NAME = FunctionCode(withType: AccessoryTypeSet.GAS_SENSOR, value: 253, nameForDebug: "GAS_NAME", andParser: DataParser.STRING);
    public static let VIBRATE_SWITCH = FunctionCode(withType: AccessoryTypeSet.VIBRATE_SENSOR, value: 1, nameForDebug: "VIBRATE_SWITCH", andParser: DataParser.BOOLEAN);
    public static let VIBRATE_CONNECTION = FunctionCode(withType: AccessoryTypeSet.VIBRATE_SENSOR, value: 3, nameForDebug: "VIBRATE_CONNECTION", andParser: DataParser.BOOLEAN);
    public static let VIBRATE_TRIGGER = FunctionCode(withType: AccessoryTypeSet.VIBRATE_SENSOR, value: 5, nameForDebug: "VIBRATE_TRIGGER", andParser: DataParser.BOOLEAN);
    public static let VIBRATE_ALARM = FunctionCode(withType: AccessoryTypeSet.VIBRATE_SENSOR, value: 7, nameForDebug: "VIBRATE_ALARM", andParser: DataParser.BOOLEAN);
    public static let VIBRATE_SOS = FunctionCode(withType: AccessoryTypeSet.VIBRATE_SENSOR, value: 9, nameForDebug: "VIBRATE_SOS", andParser: DataParser.BOOLEAN);
    public static let VIBRATE_POWER = FunctionCode(withType: AccessoryTypeSet.VIBRATE_SENSOR, value: 11, nameForDebug: "VIBRATE_POWER", andParser: DataParser.INTEGER);
    public static let VIBRATE_NAME = FunctionCode(withType: AccessoryTypeSet.VIBRATE_SENSOR, value: 253, nameForDebug: "VIBRATE_NAME", andParser: DataParser.STRING);
    public static let SIREN_SWITCH = FunctionCode(withType: AccessoryTypeSet.SIREN_SENSOR, value: 1, nameForDebug: "SIREN_SWITCH", andParser: DataParser.BOOLEAN);
    public static let SIREN_CONNECTION = FunctionCode(withType: AccessoryTypeSet.SIREN_SENSOR, value: 3, nameForDebug: "SIREN_CONNECTION", andParser: DataParser.BOOLEAN);
    public static let SIREN_TRIGGER = FunctionCode(withType: AccessoryTypeSet.SIREN_SENSOR, value: 5, nameForDebug: "SIREN_TRIGGER", andParser: DataParser.BOOLEAN);
    public static let SIREN_ALARM = FunctionCode(withType: AccessoryTypeSet.SIREN_SENSOR, value: 7, nameForDebug: "SIREN_ALARM", andParser: DataParser.BOOLEAN);
    public static let SIREN_SOS = FunctionCode(withType: AccessoryTypeSet.SIREN_SENSOR, value: 9, nameForDebug: "SIREN_SOS", andParser: DataParser.BOOLEAN);
    public static let SIREN_POWER = FunctionCode(withType: AccessoryTypeSet.SIREN_SENSOR, value: 11, nameForDebug: "SIREN_POWER", andParser: DataParser.INTEGER);
    public static let SIREN_NAME = FunctionCode(withType: AccessoryTypeSet.SIREN_SENSOR, value: 253, nameForDebug: "SIREN_NAME", andParser: DataParser.STRING);
    public static let GATEWAY_NAME = FunctionCode(withType: AccessoryTypeSet.GATEWAY, value: 253, nameForDebug: "GATEWAY_NAME", andParser: DataParser.STRING);
    public static let GATEWAY_DEFENCE = FunctionCode(withType: AccessoryTypeSet.GATEWAY, value: 3, nameForDebug: "GATEWAY_DEFENCE", andParser: DataParser.BOOLEAN);
    
    public func map(value: Int, _ objs: NSObject ...) -> FunctionCode {
        let mappings: [AccessoryTypeSet.AccessoryType: [FunctionCode]] = [
            AccessoryTypeSet.PLUG: [
                V1FunctionCodeSet.PLUG_SWITCH,
                V1FunctionCodeSet.PLUG_WATT,
                V1FunctionCodeSet.PLUG_AMPERE,
                V1FunctionCodeSet.PLUG_VOLT,
                V1FunctionCodeSet.PLUG_NAME
            ],
            AccessoryTypeSet.LIGHT: [
                V1FunctionCodeSet.LIGHT_SWITCH,
                V1FunctionCodeSet.LIGHT_BRIGHTNESS,
                V1FunctionCodeSet.LIGHT_COLOR,
                V1FunctionCodeSet.LIGHT_HUE,
                V1FunctionCodeSet.LIGHT_SATURATION,
                V1FunctionCodeSet.LIGHT_COLOR_TEMPERATURE,
                V1FunctionCodeSet.LIGHT_NAME
            ],
            AccessoryTypeSet.WATERLEAK_SENSOR: [
                V1FunctionCodeSet.WATERLEAK_SWITCH,
                V1FunctionCodeSet.WATERLEAK_CONNECTION,
                V1FunctionCodeSet.WATERLEAK_TRIGGER,
                V1FunctionCodeSet.WATERLEAK_ALARM,
                V1FunctionCodeSet.WATERLEAK_SOS,
                V1FunctionCodeSet.WATERLEAK_POWER,
                V1FunctionCodeSet.WATERLEAK_NAME
            ],
            AccessoryTypeSet.PIR_SENSOR: [
                V1FunctionCodeSet.PIR_SWITCH,
                V1FunctionCodeSet.PIR_CONNECTION,
                V1FunctionCodeSet.PIR_TRIGGER,
                V1FunctionCodeSet.PIR_ALARM,
                V1FunctionCodeSet.PIR_SOS,
                V1FunctionCodeSet.PIR_POWER,
                V1FunctionCodeSet.PIR_NAME
            ],
            AccessoryTypeSet.SMOKE_SENSOR: [
                V1FunctionCodeSet.SMOKE_SWITCH,
                V1FunctionCodeSet.SMOKE_CONNECTION,
                V1FunctionCodeSet.SMOKE_TRIGGER,
                V1FunctionCodeSet.SMOKE_ALARM,
                V1FunctionCodeSet.SMOKE_SOS,
                V1FunctionCodeSet.SMOKE_POWER,
                V1FunctionCodeSet.SMOKE_NAME
            ],
            AccessoryTypeSet.LEAK_SENSOR: [
                V1FunctionCodeSet.LEAK_SWITCH,
                V1FunctionCodeSet.LEAK_CONNECTION,
                V1FunctionCodeSet.LEAK_TRIGGER,
                V1FunctionCodeSet.LEAK_ALARM,
                V1FunctionCodeSet.LEAK_SOS,
                V1FunctionCodeSet.LEAK_POWER,
                V1FunctionCodeSet.LEAK_NAME
            ],
            AccessoryTypeSet.GAS_SENSOR: [
                V1FunctionCodeSet.GAS_SWITCH,
                V1FunctionCodeSet.GAS_CONNECTION,
                V1FunctionCodeSet.GAS_TRIGGER,
                V1FunctionCodeSet.GAS_ALARM,
                V1FunctionCodeSet.GAS_SOS,
                V1FunctionCodeSet.GAS_POWER,
                V1FunctionCodeSet.GAS_NAME
            ],
            AccessoryTypeSet.VIBRATE_SENSOR: [
                V1FunctionCodeSet.VIBRATE_SWITCH,
                V1FunctionCodeSet.VIBRATE_CONNECTION,
                V1FunctionCodeSet.VIBRATE_TRIGGER,
                V1FunctionCodeSet.VIBRATE_ALARM,
                V1FunctionCodeSet.VIBRATE_SOS,
                V1FunctionCodeSet.VIBRATE_POWER,
                V1FunctionCodeSet.VIBRATE_NAME
            ],
            AccessoryTypeSet.SIREN_SENSOR: [
                V1FunctionCodeSet.SIREN_SWITCH,
                V1FunctionCodeSet.SIREN_CONNECTION,
                V1FunctionCodeSet.SIREN_TRIGGER,
                V1FunctionCodeSet.SIREN_ALARM,
                V1FunctionCodeSet.SIREN_SOS,
                V1FunctionCodeSet.SIREN_POWER,
                V1FunctionCodeSet.SIREN_NAME
            ],
            AccessoryTypeSet.GATEWAY: [
                V1FunctionCodeSet.GATEWAY_NAME,
                V1FunctionCodeSet.GATEWAY_DEFENCE
            ]
        ]
        
        let type = objs[0] as! AccessoryTypeSet.AccessoryType
        for (targetType, targetFunctionCodes) in mappings {
            if type == targetType {
                for targetFunctionCode in targetFunctionCodes {
                    if targetFunctionCode.value == value { return targetFunctionCode}
                }
            }
        }
        return V1FunctionCodeSet.UNKNOWN
    }
    
    public class DataParser {
        
        public static let DEFAULT = DataParser { _ -> AnyObject? in return nil }
        public static let BOOLEAN = DataParser {
            let raw = UnsafePointer<UInt8>($0.bytes)
            return raw[0] > 0
        }
        public static let FLOAT = DataParser {
            let raw = UnsafePointer<UInt8>($0.bytes)
            if $0.length == 2 {
                return "\(0x0FFFF & ((UInt32(raw[0]) & 0x0FF) | ((UInt32(raw[1]) << 8) & 0x0FF00))).0"
            } else if $0.length == 4 {
                return "\(0x0FFFF & ((UInt32(raw[0]) & 0x0FF) | ((UInt32(raw[1]) << 8) & 0x0FF00))).\(0x0FFFF & ((UInt32(raw[2]) & 0x0FF) | ((UInt32(raw[3]) << 8) & 0x0FF00)))"
            }
            return ""
        }
        public static let STRING = DataParser {
            return String(data: $0, encoding: NSUTF8StringEncoding)
        }
        public static let INTEGER = DataParser {
            if $0.length == 2 {
                let raw = UnsafePointer<UInt16>($0.bytes)
                CFSwapInt16LittleToHost(raw[0])
            } else if $0.length == 4 {
                let raw = UnsafePointer<UInt32>($0.bytes)
                CFSwapInt32LittleToHost(raw[0])
            }
            return 0
        }
        
        public let parse: (data: NSData) -> AnyObject?
        init(_ parse: (data: NSData) -> AnyObject?) { self.parse = parse }
    }
    
    public class FunctionCode: NSObject {
        public let type: AccessoryTypeSet.AccessoryType
        public let value: Int
        public let nameForDebug: String
        public let parser: DataParser
        
        override public var description: String {
            return "FunctionCode{nameForDebug='\(nameForDebug)'}"
        }
        
        override public convenience init() {
            self.init(withType: AccessoryTypeSet.UNKNOWN, value: 0, nameForDebug: "UNKNOWN", andParser: DataParser.DEFAULT);
        }
        
        public func parse(functionCodeInfo: NSData) -> AnyObject? {
            return parser.parse(data: functionCodeInfo)
        }
        
        public init(withType type: AccessoryTypeSet.AccessoryType, value: Int, nameForDebug name: String, andParser parser: DataParser) {
            self.type = type
            self.value = value
            self.nameForDebug = name
            self.parser = parser
        }
    }
}