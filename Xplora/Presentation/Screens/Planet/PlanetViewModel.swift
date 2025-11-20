//
//  PlanetViewModel.swift
//  Xplora
//
//  Created by valentina balde on 11/17/25.
//

import Foundation

@MainActor
final class PlanetViewModel: ObservableObject {
    
    enum MenuItem {
        case statistics
        case myTrips
        case wishlist

        var title: String {
            switch self {
            case .statistics: return "Statistics"
            case .myTrips:    return "My trips"
            case .wishlist:   return "Wishlist"
            }
        }
    }
    
    @Published var countries: [Country] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var exploredWorldPercent: Int = 0
    @Published var visitedCountriesCount: Int = 0
    @Published var selectedMenu: MenuItem = .statistics

    private let getVisitedCountriesUseCase: GetVisitedCountriesUseCase
    private let totalCountriesInWorld = 195

    init(getVisitedCountriesUseCase: GetVisitedCountriesUseCase) {
        self.getVisitedCountriesUseCase = getVisitedCountriesUseCase
    }

    func load() {
        Task {
            isLoading = true
            do {
                let result = try await getVisitedCountriesUseCase.execute()
                countries = result
                visitedCountriesCount = result.count

                exploredWorldPercent = Int(
                    (Double(result.count) / Double(totalCountriesInWorld)) * 100.0
                )

                errorMessage = nil
            } catch {
                errorMessage = "Failed to load data"
            }
            isLoading = false
        }
    }
    func selectMenu(_ item: MenuItem) {
        selectedMenu = item
    }
}
