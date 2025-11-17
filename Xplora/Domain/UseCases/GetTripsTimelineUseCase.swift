//
//  GetTripsTimelineUseCase.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import Foundation

protocol GetTripsTimelineUseCase {
    func execute() async throws -> [Trip]
}

final class GetTripsTimelineUseCaseImpl: GetTripsTimelineUseCase {
    private let tripsRepo: TripsRepo
    
    init(tripsRepo: TripsRepo) {
        self.tripsRepo = tripsRepo
    }
    
    func execute() async throws -> [Trip] {
        try await tripsRepo.getAllTrips()
    }
}
