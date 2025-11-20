//
//  PlanetViewController.swift
//  Xplora
//
//  Created by valentina balde on 11/19/25.
//

import UIKit

final class PlanetViewController: UIViewController {
    
    private let viewModel: PlanetViewModel
    
    init(viewModel: PlanetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let label = UILabel()
        label.text = "tbd"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func didTapStatistics() {
        viewModel.selectMenu(.statistics)
    }
    @objc private func didTapMyTrips() {
        viewModel.selectMenu(.myTrips)
    }
    @objc private func didTapWishlist() {
        viewModel.selectMenu(.wishlist)
    }
}
