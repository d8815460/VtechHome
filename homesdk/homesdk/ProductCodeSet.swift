//
//  ProductCodeSet.swift
//  homesdk
//
//  Created by David Lin on 2/23/16.
//  Copyright © 2016 TUTK. All rights reserved.
//

import Foundation

public class ProductCodeSet: NSObject {
    
    public static let UNKNOWN = ProductCode(withValue: 0x00, andName: "UNKNOWN")
    public static let IPCAMERA = ProductCode(withValue: 0x3FF, andName: "IPCAMERA")
    public static let SMARTPOWERSTRIP = ProductCode(withValue: 0xFF, andName: "SMARTPOWERSTRIP")
    public static let SMARTOUTLET = ProductCode(withValue: 0xFE, andName: "UNKNOWN")
    public static let SMARTOUTLET_STT_TYPEA = ProductCode(withValue: 0xFD, andName: "SMARTOUTLET_STT_TYPEA")
    public static let SMARTOUTLET_STT_TYPEB = ProductCode(withValue: 0xFC, andName: "SMARTOUTLET_STT_TYPEB")
    public static let SMARTIRREMOTE = ProductCode(withValue: 0xFB, andName: "SMARTIRREMOTE")
    public static let ABOCOMOUTLET = ProductCode(withValue: 0xFA, andName: "ABOCOMOUTLET")
    public static let BILINK_4CHANNEL_POWERSTRIP = ProductCode(withValue: 0xF9, andName: "BILINK_4CHANNEL_POWERSTRIP")
    public static let HOMEGATEWAY = ProductCode(withValue: 0xF8, andName: "HOMEGATEWAY")
    public static let PHILIPSLIGHT = ProductCode(withValue: 0xF7, andName: "PHILIPSLIGHT")
    public static let BOSCH = ProductCode(withValue: 0xF6, andName: "BOSCH")
    public static let EUROPEANZHITONG = ProductCode(withValue: 0xF5, andName: "EUROPEANZHITONG")
    public static let TUTKGATEWAY = ProductCode(withValue: 0xF4, andName: "TUTKGATEWAY")
    public static let SAMPO_AIR_CONDITIONER = ProductCode(withValue: 0xF3, andName: "SAMPO_AIR_CONDITIONER")
    public static let TUTK_PLUG = ProductCode(withValue: 0xF2, andName: "TUTK_PLUG")
    public static let TUTK_LIGHT = ProductCode(withValue: 0xF1, andName: "TUTK_LIGHT")
    public static let TUTK_PIR = ProductCode(withValue: 0xEF, andName: "TUTK_PIR")
    public static let TUTK_DOOR = ProductCode(withValue: 0xEE, andName: "TUTK_DOOR")
    public static let TUTK_WATER = ProductCode(withValue: 0xED, andName: "TUTK_WATER")
    public static let TUTK_SMOKE = ProductCode(withValue: 0xEC, andName: "TUTK_SMOKE")
    public static let TUTK_SIREN = ProductCode(withValue: 0xEB, andName: "TUTK_SIREN")
    public static let TUTK_GAS = ProductCode(withValue: 0xEA, andName: "TUTK_GAS")
    public static let TUTK_VIBRATE = ProductCode(withValue: 0xE9, andName: "TUTK_VIBRATE")
    
    public func map(value: NSInteger) -> ProductCode {
        let allCodes: [ProductCode] = [
            ProductCodeSet.IPCAMERA,
            ProductCodeSet.SMARTPOWERSTRIP,
            ProductCodeSet.SMARTOUTLET,
            ProductCodeSet.SMARTOUTLET_STT_TYPEA,
            ProductCodeSet.SMARTOUTLET_STT_TYPEB,
            ProductCodeSet.SMARTIRREMOTE,
            ProductCodeSet.ABOCOMOUTLET,
            ProductCodeSet.BILINK_4CHANNEL_POWERSTRIP,
            ProductCodeSet.HOMEGATEWAY,
            ProductCodeSet.PHILIPSLIGHT,
            ProductCodeSet.BOSCH,
            ProductCodeSet.EUROPEANZHITONG,
            ProductCodeSet.TUTKGATEWAY,
            ProductCodeSet.SAMPO_AIR_CONDITIONER,
            ProductCodeSet.TUTK_PLUG,
            ProductCodeSet.TUTK_LIGHT,
            ProductCodeSet.TUTK_PIR,
            ProductCodeSet.TUTK_DOOR,
            ProductCodeSet.TUTK_WATER,
            ProductCodeSet.TUTK_SMOKE,
            ProductCodeSet.TUTK_SIREN,
            ProductCodeSet.TUTK_GAS,
            ProductCodeSet.TUTK_VIBRATE];

        for code in allCodes {
            if code.value == value { return code }
        }
        return ProductCodeSet.UNKNOWN
    }
    
    public class ProductCode: CustomStringConvertible {
        public private(set) var value: NSInteger
        public private(set) var name: String
        
        public var description: String {
            return "ProductCode{value=\(value), name=\(name)}"
        }
        
        public convenience init() {
            self.init(withValue: NSInteger.min, andName: "")
        }
        
        public init(withValue value: NSInteger, andName name: String) {
            self.value = value
            self.name = name
        }
    }
}