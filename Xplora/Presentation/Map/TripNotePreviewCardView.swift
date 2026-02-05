//
//  TripNotePreviewCardView.swift
//  Xplora

import UIKit

final class TripNotePreviewCardView: UIView {
    enum PresentationState {
        case hidden
        case visible
    }

    private let shadowContainer = UIView()
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    private let collageView = TripPhotosCollageView()
    private var collageHeightConstraint: NSLayoutConstraint?
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let placeCapsule = UIView()
    private let placeIcon = UIImageView()
    private let placeLabel = UILabel()
    private let previewLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func configure(with viewModel: TripNotePreviewViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.dateRange
        previewLabel.text = viewModel.textPreview
        collageView.configure(images: viewModel.photos)
        let hasPhotos = !viewModel.photos.isEmpty
        collageView.isHidden = !hasPhotos
        collageHeightConstraint?.isActive = false
        collageHeightConstraint = hasPhotos
            ? collageView.heightAnchor.constraint(equalTo: collageView.widthAnchor, multiplier: 193.0 / 258.0)
            : collageView.heightAnchor.constraint(equalToConstant: 0)
        collageHeightConstraint?.isActive = true
        if let placeTitle = viewModel.placeTitle, !placeTitle.isEmpty {
            placeLabel.text = placeTitle
            placeCapsule.isHidden = false
        } else {
            placeCapsule.isHidden = true
        }
    }

    func applyPresentationState(_ state: PresentationState) {
        switch state {
        case .hidden:
            alpha = 0
            transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            isHidden = true
        case .visible:
            isHidden = false
            alpha = 1
            transform = .identity
        }
    }

    private func setupView() {
        backgroundColor = .clear

        shadowContainer.translatesAutoresizingMaskIntoConstraints = false
        shadowContainer.layer.shadowColor = UIColor.black.cgColor
        shadowContainer.layer.shadowOpacity = 0.15
        shadowContainer.layer.shadowRadius = 18
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 8)
        addSubview(shadowContainer)

        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 22
        blurView.clipsToBounds = true
        shadowContainer.addSubview(blurView)

        collageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2

        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textColor = .secondaryLabel

        placeCapsule.translatesAutoresizingMaskIntoConstraints = false
        placeCapsule.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        placeCapsule.layer.cornerRadius = 12
        placeCapsule.clipsToBounds = true

        placeIcon.translatesAutoresizingMaskIntoConstraints = false
        placeIcon.image = UIImage(systemName: "mappin.and.ellipse")
        placeIcon.tintColor = .secondaryLabel

        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        placeLabel.textColor = .label
        placeLabel.numberOfLines = 1

        previewLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        previewLabel.textColor = .secondaryLabel
        previewLabel.numberOfLines = 4

        let infoStack = UIStackView(arrangedSubviews: [titleLabel, dateLabel, placeCapsule, previewLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 8
        infoStack.translatesAutoresizingMaskIntoConstraints = false

        blurView.contentView.addSubview(collageView)
        blurView.contentView.addSubview(infoStack)

        placeCapsule.addSubview(placeIcon)
        placeCapsule.addSubview(placeLabel)

        collageHeightConstraint = collageView.heightAnchor.constraint(equalTo: collageView.widthAnchor, multiplier: 193.0 / 258.0)

        NSLayoutConstraint.activate([
            shadowContainer.topAnchor.constraint(equalTo: topAnchor),
            shadowContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowContainer.trailingAnchor.constraint(equalTo: trailingAnchor),

            blurView.topAnchor.constraint(equalTo: shadowContainer.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: shadowContainer.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: shadowContainer.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: shadowContainer.trailingAnchor),

            collageView.topAnchor.constraint(equalTo: blurView.contentView.topAnchor),
            collageView.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor),
            collageView.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor),
            collageHeightConstraint!,

            infoStack.topAnchor.constraint(equalTo: collageView.bottomAnchor, constant: 12),
            infoStack.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: 14),
            infoStack.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -14),
            infoStack.bottomAnchor.constraint(lessThanOrEqualTo: blurView.contentView.bottomAnchor, constant: -14),

            placeIcon.leadingAnchor.constraint(equalTo: placeCapsule.leadingAnchor, constant: 10),
            placeIcon.centerYAnchor.constraint(equalTo: placeCapsule.centerYAnchor),
            placeIcon.widthAnchor.constraint(equalToConstant: 14),
            placeIcon.heightAnchor.constraint(equalToConstant: 14),

            placeLabel.leadingAnchor.constraint(equalTo: placeIcon.trailingAnchor, constant: 6),
            placeLabel.trailingAnchor.constraint(equalTo: placeCapsule.trailingAnchor, constant: -10),
            placeLabel.topAnchor.constraint(equalTo: placeCapsule.topAnchor, constant: 8),
            placeLabel.bottomAnchor.constraint(equalTo: placeCapsule.bottomAnchor, constant: -8)
        ])
    }
}
