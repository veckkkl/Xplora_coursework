//
//  CountryVisitMarkersRepo.swift
//  Xplora


import Foundation

protocol CountryVisitMarkersRepo {
    func getCountryVisitMarkers() async throws -> [CountryVisitMarker]
}
