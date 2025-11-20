//
//  Country.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

struct Country: Identifiable, Equatable, Codable {
    let id: UUID
    let code: String        // "US", "RU"
    let name: String
    let regions: [Region]  
}

struct Region: Identifiable, Equatable, Codable {
    let id: UUID
    let name: String
    let isVisited: Bool
}
