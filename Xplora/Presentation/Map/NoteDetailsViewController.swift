//
//  NoteDetailsViewController.swift
//  Xplora


import SnapKit
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
        label.textAlignment = .center
        label.numberOfLines = 0
        if let noteId {
            label.text = "First note for \(countryCode)\nID: \(noteId)"
        } else {
            label.text = "First note for \(countryCode)"
        }
        view.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview().offset(-24)
        }
    }
}
