//
//  TripPhotoTileCell.swift
//  Xplora


import UIKit

final class TripPhotosCollageCell: UICollectionViewCell {
    static let reuseIdentifier = "TripPhotosCollageCell"

    private let imageView = UIImageView()
    private let overlayView = UIView()
    private let overlayLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func configure(image: UIImage, overflowCount: Int) {
        imageView.image = image
        if overflowCount > 0 {
            overlayView.isHidden = false
            overlayLabel.text = "+\(overflowCount)"
        } else {
            overlayView.isHidden = true
            overlayLabel.text = nil
        }
    }

    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 2
        contentView.clipsToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)

        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        overlayView.isHidden = true
        contentView.addSubview(overlayView)

        overlayLabel.translatesAutoresizingMaskIntoConstraints = false
        overlayLabel.textColor = .white
        overlayLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        overlayView.addSubview(overlayLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            overlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            overlayLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            overlayLabel.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
        ])
    }
}
