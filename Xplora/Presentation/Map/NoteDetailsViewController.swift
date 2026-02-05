//
//  NoteDetailsViewController.swift
//  Xplora


import UIKit

final class NoteDetailsViewController: UIViewController {
    private let countryCode: String
    private let noteId: String?

    init(countryCode: String, noteId: String?) {
        self.countryCode = countryCode
        self.noteId = noteId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Trip Note"

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        if let noteId {
            label.text = "First note for \(countryCode)\nID: \(noteId)"
        } else {
            label.text = "First note for \(countryCode)"
        }
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
        ])
    }
}
