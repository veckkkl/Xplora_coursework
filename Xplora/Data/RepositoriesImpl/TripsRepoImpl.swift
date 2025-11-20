//
//  TripsRepoImpl.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

final class TripsRepoImpl: TripsRepo {
    private let storage: LocalStorageProtocol

    init(storage: LocalStorageProtocol) {
        self.storage = storage
    }

    func getAllTrips() async throws -> [Trip] {
        storage.trips
    }

    func save(trip: Trip) async throws {
        var trips = storage.trips
        trips.append(trip)
        storage.trips = trips
    }
}

