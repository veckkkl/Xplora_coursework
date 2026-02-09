//
//  TripNoteCalloutView.swift
//  Xplora
//
//  Created by valentina balde on 11/22/25.
//

import SnapKit
import UIKit

final class TripNoteCalloutView: UIView {
    var onTap: (() -> Void)?

    private let contentView = TripNoteCalloutContentView()

    init(model: TripNotePreviewViewModel) {
        super.init(frame: .zero)
        setupView()
        contentView.configure(with: model)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        addSubview(contentView)

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(240).priority(.high)
            make.width.lessThanOrEqualTo(260).priority(.required)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        onTap?()
    }
}
