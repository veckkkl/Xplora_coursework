//
//  TripsRepoImpl.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

final class TripsRepoImpl: TripsRepo {
    private let storage: LocalStorage
    
    init(storage: LocalStorage) {
        self.storage = storage
    }
    
    func getAllTrips() async throws -> [Trip] { storage.trips }
    func save(trip: Trip) async throws { storage.trips.append(trip) }
}
