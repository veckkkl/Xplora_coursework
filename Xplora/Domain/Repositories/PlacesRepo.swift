//
//  PlacesRepo.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

protocol PlacesRepo {
    func getVisitedCountries() async throws -> [Country]
    func addVisitedPlace(_ place: VisitedPlace, to trip: Trip?) async throws
}
