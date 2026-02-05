//
//  TripPhotoCell.swift
//  Xplora


import UIKit

final class TripPhotoCell: UICollectionViewCell {
    static let reuseIdentifier = "TripPhotoCell"

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func configure(image: UIImage) {
        imageView.image = image
    }

    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 2
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.clipsToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
