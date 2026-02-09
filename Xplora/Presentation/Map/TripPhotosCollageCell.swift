//
//  TripPhotoTileCell.swift
//  Xplora


import SnapKit
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

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)

        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        overlayView.isHidden = true
        contentView.addSubview(overlayView)

        overlayLabel.textColor = .white
        overlayLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        overlayView.addSubview(overlayLabel)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        overlayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
