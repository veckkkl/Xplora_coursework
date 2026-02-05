//
//  MainTabBarController.swift
//  Xplora

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

    private func configureAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.7)
        appearance.shadowColor = .clear

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.isTranslucent = true
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .secondaryLabel
    }
}
