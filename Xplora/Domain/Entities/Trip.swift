//
//  Trip.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

struct Trip: Identifiable, Equatable {
    let id: UUID
    let title: String
    let startDate: Date
    let endDate: Date?
    let visitedPlaces: [VisitedPlace]
}

struct VisitedPlace: Identifiable, Equatable {
    let id: UUID
    let city: City
    let date: Date
}
