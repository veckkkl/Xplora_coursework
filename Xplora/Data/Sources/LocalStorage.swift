//
//  LocalStorage.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

final class LocalStorage {
    static let shared = LocalStorage()
    
    private init() {}
    
    //потом заменю на CoreData
    var trips: [Trip] = []
    var countries: [Country] = []
    var settings = UserSettings(preferredUnits: .kilometers, showFog: true)
}
