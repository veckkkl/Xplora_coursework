//
//  AddTripNoteViewController.swift
//  Xplora


import SnapKit
import UIKit

final class AddTripNoteViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Add Note"

        let label = UILabel()
        label.text = "Add note (stub)"
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview().offset(-24)
        }
    }
}
