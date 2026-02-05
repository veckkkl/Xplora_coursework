//
//  CountryVisitMarkersRepoImpl.swift
//  Xplora


import CoreLocation

final class CountryVisitMarkersRepoImpl: CountryVisitMarkersRepo {
    func getCountryVisitMarkers() async throws -> [CountryVisitMarker] {
        return [
            CountryVisitMarker(
                countryCode: "FR",
                title: "Paris, France",
                dateRangeText: "14 Aug 2024 - 17 Aug 2024",
                coordinate: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                firstNoteId: "note-paris-1"
            ),
            CountryVisitMarker(
                countryCode: "ES",
                title: "Barcelona, Spain",
                dateRangeText: "13 Sep 2021 - 20 Sep 2021",
                coordinate: CLLocationCoordinate2D(latitude: 41.3851, longitude: 2.1734),
                firstNoteId: "note-barcelona-1"
            )
        ]
    }
}
