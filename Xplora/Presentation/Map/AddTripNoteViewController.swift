//
//  AddTripNoteViewController.swift
//  Xplora


import UIKit

final class AddTripNoteViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Add Note"

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add note (stub)"
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
        ])
    }
}
