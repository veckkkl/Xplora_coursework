//
//  ServiceLocator.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

final class ServiceLocator {
    static let shared = ServiceLocator()
    
    private let storage = LocalStorage.shared
    
    // Repos
    lazy var tripsRepo: TripsRepo = TripsRepoImpl(storage: storage)
    lazy var placesRepo: PlacesRepo = PlacesRepoImpl(storage: storage)
    lazy var settingsRepo: SettingsRepo = SettingsRepoImpl(storage: storage)
    
    // Services
    lazy var locationService: LocationService = LocationServiceImpl()
    lazy var mistLogicService: FogLogicService = FogLogicServiceImpl()
    
    // UseCases
    lazy var getVisitedCountriesUseCase: GetVisitedCountriesUseCase =
        GetVisitedCountriesUseCaseImpl(placesRepo: placesRepo)
    
    lazy var getTripsTimelineUseCase: GetTripsTimelineUseCase =
        GetTripsTimelineUseCaseImpl(tripsRepo: tripsRepo)
    
    lazy var addVisitedPlaceUseCase: AddVisitedPlaceUseCase =
        AddVisitedPlaceUseCaseImpl(placesRepo: placesRepo)
}

