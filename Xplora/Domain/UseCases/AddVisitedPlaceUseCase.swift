//
//  AddVisitedPlaceUseCase.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

protocol AddVisitedPlaceUseCase {
    func execute(place: VisitedPlace, trip: Trip?) async throws
}

final class AddVisitedPlaceUseCaseImpl: AddVisitedPlaceUseCase {
    private let placesRepo: PlacesRepo
    
    init(placesRepo: PlacesRepo) {
        self.placesRepo = placesRepo
    }
    
    func execute(place: VisitedPlace, trip: Trip?) async throws {
        try await placesRepo.addVisitedPlace(place, to: trip)
    }
}
