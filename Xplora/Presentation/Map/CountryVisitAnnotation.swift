//
//  CountryVisitAnnotation.swift
//  Xplora


import MapKit

final class CountryVisitAnnotation: NSObject, MKAnnotation {
    let marker: CountryVisitMarker

    var coordinate: CLLocationCoordinate2D {
        marker.coordinate
    }

    var title: String? { nil }

    var subtitle: String? { nil }

    var countryCode: String {
        marker.countryCode
    }

    var dateRangeText: String {
        marker.dateRangeText
    }

    var firstNoteId: String? {
        marker.firstNoteId
    }

    init(marker: CountryVisitMarker) {
        self.marker = marker
    }
}
