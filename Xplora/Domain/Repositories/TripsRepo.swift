//
//  TripRepo.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

protocol TripsRepo {
    func getAllTrips() async throws -> [Trip]
    func save(trip: Trip) async throws
}

