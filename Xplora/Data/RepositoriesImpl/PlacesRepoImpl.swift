//
//  PlacesRepoImpl.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

final class PlacesRepoImpl: PlacesRepo {
    private let storage: LocalStorage
    
    init(storage: LocalStorage) {
        self.storage = storage
    }
    
    func getVisitedCountries() async throws -> [Country] { storage.countries }
    func addVisitedPlace(_ place: VisitedPlace, to trip: Trip?) async throws { }
}

