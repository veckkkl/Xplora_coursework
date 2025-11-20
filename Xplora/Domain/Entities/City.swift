//
//  City.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

struct City: Identifiable, Equatable, Codable {
    let id: UUID
    let name: String
    let countryCode: String
    let coordinate: LocationCoordinate
}
