//
//  GetVisitedCountriesUseCase.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

protocol GetVisitedCountriesUseCase {
    func execute() async throws -> [Country]
}

final class GetVisitedCountriesUseCaseImpl: GetVisitedCountriesUseCase {
    private let placesRepo: PlacesRepo
    
    init(placesRepo: PlacesRepo) {
        self.placesRepo = placesRepo
    }
    
    func execute() async throws -> [Country] {
        try await placesRepo.getVisitedCountries()
    }
}
