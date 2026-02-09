//
//  MapViewModel.swift
//  Xplora


import Foundation
import MapKit
import UIKit

@MainActor
protocol MapViewModelInput: AnyObject {
    func viewDidLoad()
    func didTapAddNote()
    func didSelectMarker(_ marker: CountryVisitMarker)
    func previewModel(for marker: CountryVisitMarker) -> TripNotePreviewViewModel
}

@MainActor
protocol MapViewModelOutput: AnyObject {
    var onMarkersUpdated: (([CountryVisitMarker]) -> Void)? { get set }
    var onOverlaysUpdated: (([MKOverlay]) -> Void)? { get set }
    var onRoute: ((MapRoute) -> Void)? { get set }
}

enum MapRoute {
    case addNote
    case showCountryFirstNote(countryCode: String, noteId: String?)
}

@MainActor
final class MapViewModel: MapViewModelInput, MapViewModelOutput {
    var onMarkersUpdated: (([CountryVisitMarker]) -> Void)?
    var onOverlaysUpdated: (([MKOverlay]) -> Void)?
    var onRoute: ((MapRoute) -> Void)?

    private let getCountryVisitMarkersUseCase: GetCountryVisitMarkersUseCase
    private let fogOverlayProvider: FogOverlayProviding
    private let locationService: LocationService

    init(
        getCountryVisitMarkersUseCase: GetCountryVisitMarkersUseCase,
        fogOverlayProvider: FogOverlayProviding,
        locationService: LocationService
    ) {
        self.getCountryVisitMarkersUseCase = getCountryVisitMarkersUseCase
        self.fogOverlayProvider = fogOverlayProvider
        self.locationService = locationService
    }

    func viewDidLoad() {
        locationService.requestWhenInUseAuthorization()
        locationService.startUpdatingLocation()
        loadMarkers()
    }

    func didTapAddNote() {
        onRoute?(.addNote)
    }

    func didSelectMarker(_ marker: CountryVisitMarker) {
        onRoute?(.showCountryFirstNote(countryCode: marker.countryCode, noteId: marker.firstNoteId))
    }

    func previewModel(for marker: CountryVisitMarker) -> TripNotePreviewViewModel {
        TripNotePreviewViewModel(
            title: marker.title,
            dateRange: marker.dateRangeText,
            photos: makeMockPhotos(),
            placeTitle: "La Fromagerie Goncourt",
            textPreview: "A rainy afternoon turned into a perfect evening. We found a tiny café, tried local cheese, and watched the city lights reflect on the wet streets."
        )
    }

    private func makeMockPhotos() -> [UIImage] {
        let colors: [UIColor] = [
            UIColor.systemOrange,
            UIColor.systemPink,
            UIColor.systemBlue
        ]
        return colors.map { color in
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200))
            return renderer.image { context in
                color.setFill()
                context.fill(CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
            }
        }
    }

    private func loadMarkers() {
        Task {
            do {
                let markers = try await getCountryVisitMarkersUseCase.execute()
                onMarkersUpdated?(markers)
                onOverlaysUpdated?([])
            } catch {
                onMarkersUpdated?([])
                onOverlaysUpdated?([])
            }
        }
    }
}
