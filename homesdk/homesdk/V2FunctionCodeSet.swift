//
//  V2FunctionCodeSet.swift
//  homesdk
//
//  Created by David Lin on 2/24/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation


public class V2FunctionCodeSet: NSObject {
    
    public static let UNKNOWN = FunctionCode()
    public static let CONNECTION = FunctionCode(withKey: "connection", nameForDebug: "連線狀況", readOnly: true, andParser: DataParser.INTEGER)
    public static let PRODUCT_CODE = FunctionCode(withKey: "product_code", nameForDebug: "產品編號", readOnly: true, andParser: DataParser.INTEGER)
    public static let PRODUCT_NAME = FunctionCode(withKey: "product_name", nameForDebug: "產品名稱", readOnly: true, andParser: DataParser.STRING)
    public static let PASSWORD = FunctionCode(withKey: "password", nameForDebug: "設備密碼", readOnly: false, andParser: DataParser.STRING)
    public static let WIFI_LIST = FunctionCode(withKey: "wifi_list", nameForDebug: "WiFi列表", readOnly: true, andParser: DataParser.DEFAULT)
    public static let WIFI = FunctionCode(withKey: "wifi", nameForDebug: "WiFi相關(設定)", readOnly:false, andParser: DataParser.DEFAULT)
    public static let TYPE_LIST = FunctionCode(withKey: "type_list", nameForDebug: "種類列表", readOnly:true, andParser: DataParser.DEFAULT)
    public static let SWITCH = FunctionCode(withKey: "switch", nameForDebug: "開關", readOnly:false, andParser:DataParser.BOOLEAN)
    public static let NAME = FunctionCode(withKey: "name", nameForDebug: "設備名稱", readOnly:false, andParser: DataParser.STRING)
    public static let AUTHENTICATION = FunctionCode(withKey: "authentication", nameForDebug: "授權", readOnly:true, andParser: DataParser.BOOLEAN)
    public static let WATT = FunctionCode(withKey: "watt", nameForDebug: "瓦數", readOnly:true, andParser:DataParser.FLOAT)
    public static let AMPERE = FunctionCode(withKey: "ampere", nameForDebug: "安培數", readOnly:true, andParser: DataParser.FLOAT)
    public static let VOLT = FunctionCode(withKey: "volt", nameForDebug: "伏特數", readOnly:true, andParser:DataParser.FLOAT)
    public static let BRIGHTNESS = FunctionCode(withKey: "brightness", nameForDebug: "亮度", readOnly:false, andParser: DataParser.FLOAT)
    public static let COLOR = FunctionCode(withKey: "color", nameForDebug: "最終顯示顏色", readOnly:false, andParser: DataParser.INTEGER)
    public static let HUE = FunctionCode(withKey: "hue", nameForDebug: "HUE", readOnly:false, andParser:DataParser.FLOAT)
    public static let SATURATION = FunctionCode(withKey: "saturation", nameForDebug: "飽和度", readOnly:false, andParser: DataParser.FLOAT)
    public static let COLOR_TEMPERATURE = FunctionCode(withKey: "color_temperature", nameForDebug: "色溫", readOnly:false, andParser: DataParser.FLOAT)
    public static let TRIGGER = FunctionCode(withKey: "trigger", nameForDebug: "觸發狀態", readOnly:true, andParser: DataParser.BOOLEAN)
    public static let ALARM = FunctionCode(withKey: "alarm", nameForDebug: "警示狀態", readOnly:true, andParser: DataParser.BOOLEAN)
    public static let SOS = FunctionCode(withKey: "sos", nameForDebug: "SOS狀態", readOnly:true, andParser: DataParser.BOOLEAN)
    public static let POWER = FunctionCode(withKey: "power", nameForDebug: "電量狀態", readOnly:true, andParser: DataParser.FLOAT)
    public static let DEFENCE = FunctionCode(withKey: "defence", nameForDebug: "佈防模式", readOnly:false, andParser: DataParser.FLOAT)
    public static let MODE = FunctionCode(withKey: "mode", nameForDebug: "狀態模式", readOnly:false, andParser: DataParser.DEFAULT)
    public static let DEVICE_MODE = FunctionCode(withKey: "device_mode", nameForDebug: "Device狀態模式", readOnly:false, andParser: DataParser.DEFAULT)
    
    public func map(key: String) -> FunctionCode {
        let mapping: [FunctionCode] = [
            V2FunctionCodeSet.CONNECTION,
            V2FunctionCodeSet.PRODUCT_CODE,
            V2FunctionCodeSet.PRODUCT_NAME,
            V2FunctionCodeSet.PASSWORD,
            V2FunctionCodeSet.WIFI_LIST,
            V2FunctionCodeSet.WIFI,
            V2FunctionCodeSet.TYPE_LIST,
            V2FunctionCodeSet.SWITCH,
            V2FunctionCodeSet.NAME,
            V2FunctionCodeSet.AUTHENTICATION,
            V2FunctionCodeSet.WATT,
            V2FunctionCodeSet.AMPERE,
            V2FunctionCodeSet.VOLT,
            V2FunctionCodeSet.BRIGHTNESS,
            V2FunctionCodeSet.COLOR,
            V2FunctionCodeSet.HUE,
            V2FunctionCodeSet.SATURATION,
            V2FunctionCodeSet.COLOR_TEMPERATURE,
            V2FunctionCodeSet.TRIGGER,
            V2FunctionCodeSet.ALARM,
            V2FunctionCodeSet.SOS,
            V2FunctionCodeSet.POWER,
            V2FunctionCodeSet.DEFENCE,
            V2FunctionCodeSet.MODE,
            V2FunctionCodeSet.DEVICE_MODE
        ]
        
        for functionCode in mapping {
            if functionCode.key == key { return functionCode }
        }
        return V2FunctionCodeSet.UNKNOWN
    }
    
    public class DataParser {
        
        public static let DEFAULT = DataParser(0)
        public static let BOOLEAN = DataParser(1)
        public static let FLOAT = DataParser(2)
        public static let STRING = DataParser(3)
        public static let INTEGER = DataParser(4)
        
        public let value: Int
        init(_ value: Int) { self.value = value }
    }
    
    public class FunctionCode: NSObject {
        public let key: String
        public let nameForDebug: String
        public let readOnly: Bool
        public let parser: DataParser
        
        override public var description: String {
            return "FunctionCode{nameForDebug='\(nameForDebug)'}"
        }
        
        override public convenience init() {
            self.init(withKey: "unknown", nameForDebug: "UNKNOWN", readOnly: true, andParser: DataParser.DEFAULT)
        }
        
        public init(withKey key: String, nameForDebug name: String, readOnly: Bool, andParser parser: DataParser) {
            self.key = key
            self.nameForDebug = name
            self.readOnly = readOnly
            self.parser = parser
        }
    }
}