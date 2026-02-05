//
//  GetCountryVisitMarkersUseCase.swift
//  Xplora
//
//  Created by valentina balde on 11/20/25.
//

import Foundation

protocol GetCountryVisitMarkersUseCase {
    func execute() async throws -> [CountryVisitMarker]
}

final class GetCountryVisitMarkersUseCaseImpl: GetCountryVisitMarkersUseCase {
    private let markersRepo: CountryVisitMarkersRepo

    init(markersRepo: CountryVisitMarkersRepo) {
        self.markersRepo = markersRepo
    }

    func execute() async throws -> [CountryVisitMarker] {
        try await markersRepo.getCountryVisitMarkers()
    }
}
