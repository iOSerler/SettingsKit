//
//  File.swift
//  
//
//  Created by Bekzhan Talgat on 07.04.2022.
//

import Foundation

public protocol SettingsAnalytics {
    func logEvent(_ eventName: String, properties: [String:Any]?)
    func setUserProperty(_ property: String, value: Any)
}
