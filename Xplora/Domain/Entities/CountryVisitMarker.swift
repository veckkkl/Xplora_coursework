//
//  CountryVisitMarker.swift
//  Xplora
//
//  Created by valentina balde on 11/20/25.
//

import CoreLocation

struct CountryVisitMarker {
    let countryCode: String
    let title: String
    let dateRangeText: String
    let coordinate: CLLocationCoordinate2D
    let firstNoteId: String?
}
