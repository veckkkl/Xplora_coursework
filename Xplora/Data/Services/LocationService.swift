//
//  LocationService.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation
import CoreLocation

protocol LocationService {
    func requestCurrentLocation() async throws -> LocationCoordinate
}

final class LocationServiceImpl: NSObject, LocationService {
    private let manager = CLLocationManager()
    
    func requestCurrentLocation() async throws -> LocationCoordinate {
        return LocationCoordinate(latitude: 0, longitude: 0)
    }
}
