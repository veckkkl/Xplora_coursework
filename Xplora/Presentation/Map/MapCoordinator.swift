//
//  MapCoordinator.swift
//  Xplora


import UIKit

@MainActor
final class MapCoordinator {
    private let navigationController: UINavigationController
    private let locator: ServiceLocator

    init(navigationController: UINavigationController, locator: ServiceLocator = .shared) {
        self.navigationController = navigationController
        self.locator = locator
    }

    func start() {
        let markersUseCase: GetCountryVisitMarkersUseCase = locator.resolve(GetCountryVisitMarkersUseCase.self)
        let fogOverlayProvider: FogOverlayProviding = locator.resolve(FogOverlayProviding.self)
        let locationService: LocationService = locator.resolve(LocationService.self)
        let viewModel = MapViewModel(
            getCountryVisitMarkersUseCase: markersUseCase,
            fogOverlayProvider: fogOverlayProvider,
            locationService: locationService
        )
        let viewController = MapViewController(viewModel: viewModel)
        viewModel.onRoute = { [weak self] route in
            self?.handle(route)
        }
        navigationController.viewControllers = [viewController]
    }

    private func handle(_ route: MapRoute) {
        switch route {
        case .addNote:
            showAddNote()
        case .showCountryFirstNote(let countryCode, let noteId):
            showCountryFirstNote(countryCode: countryCode, noteId: noteId)
        }
    }

    private func showAddNote() {
        let viewController = AddTripNoteViewController()
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showCountryFirstNote(countryCode: String, noteId: String?) {
        let viewController = NoteDetailsViewController(countryCode: countryCode, noteId: noteId)
        navigationController.pushViewController(viewController, animated: true)
    }
}
