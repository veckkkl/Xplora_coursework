//
//  UserSettings.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

struct UserSettings: Codable {
    var preferredUnits: DistanceUnit
    var showFog: Bool
    
    static let `default` = UserSettings(preferredUnits: .kilometers, showFog: true)
}

enum DistanceUnit: String, Codable {
    case kilometers
    case miles
}
