//
//  AppCoordinator.swift
//  Xplora
//
//  Created by valentina balde on 11/14/25.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let locator: ServiceLocator
    private let navigationController: UINavigationController
    
    init(window: UIWindow, locator: ServiceLocator = .shared, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.locator = locator
        self.navigationController = navigationController
    }
    
    @MainActor
    func start() {
        let getVisitedCountriesUseCase: GetVisitedCountriesUseCase = locator.resolve(GetVisitedCountriesUseCase.self)
        let planetViewModel = PlanetViewModel(getVisitedCountriesUseCase: getVisitedCountriesUseCase)
        let planetViewController = PlanetViewController(viewModel: planetViewModel)
        navigationController.viewControllers = [planetViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
