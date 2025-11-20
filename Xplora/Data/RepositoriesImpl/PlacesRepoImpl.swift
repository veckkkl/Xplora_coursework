//
//  PlacesRepoImpl.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

final class PlacesRepoImpl: PlacesRepo {
    private let storage: LocalStorageProtocol

    init(storage: LocalStorageProtocol) {
        self.storage = storage
    }

    func getVisitedCountries() async throws -> [Country] {
        storage.countries
    }

    func addVisitedPlace(_ place: VisitedPlace, to trip: Trip?) async throws {
        // логика добавления или обновления
    }
}

