//
//  UserSettings.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

struct UserSettings {
    var preferredUnits: DistanceUnit
    var showFog: Bool
}

enum DistanceUnit: String {
    case kilometers
    case miles
}
