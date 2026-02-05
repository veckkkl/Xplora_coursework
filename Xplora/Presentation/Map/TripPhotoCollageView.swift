//
//  TripPhotoCollageView.swift
//  Xplora


import UIKit

final class TripPhotoCollageView: UIView {
    private let collectionView: UICollectionView
    private var photos: [UIImage] = []

    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(coder: coder)
        setupView()
    }

    func configure(with photos: [UIImage]) {
        self.photos = photos
        collectionView.isHidden = photos.isEmpty
        collectionView.collectionViewLayout = TripPhotoCollageView.makeLayout(for: photos.count)
        collectionView.reloadData()
    }

    private func setupView() {
        clipsToBounds = true
        layer.cornerRadius = 20

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(TripPhotoCell.self, forCellWithReuseIdentifier: TripPhotoCell.reuseIdentifier)
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private static func makeLayout(for count: Int) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

            if count <= 1 {
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
                    subitems: [item]
                )
                return NSCollectionLayoutSection(group: group)
            }

            if count <= 4 {
                let smallItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5)))
                smallItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
                    subitem: smallItem,
                    count: 2
                )
                let container = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
                    subitem: group,
                    count: 2
                )
                return NSCollectionLayoutSection(group: container)
            }

            return TripPhotoCollageView.makeCollageLayout(item: item)
        }
        return layout
    }

    private static func makeCollageLayout(item: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let smallItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

        let rightGrid = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitem: smallItem,
            count: 2
        )

        let rightGridGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitems: [rightGrid, rightGrid]
        )

        let topGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.68)),
            subitems: [
                NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.55), heightDimension: .fractionalHeight(1.0)),
                    subitems: [item]
                ),
                NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(1.0)),
                    subitems: [rightGridGroup]
                )
            ]
        )

        let bottomRowItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0/3.0), heightDimension: .fractionalHeight(1.0)))
        bottomRowItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let bottomGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.32)),
            subitem: bottomRowItem,
            count: 3
        )

        let container = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitems: [topGroup, bottomGroup]
        )

        let section = NSCollectionLayoutSection(group: container)
        return section
    }
}

extension TripPhotoCollageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripPhotoCell.reuseIdentifier, for: indexPath) as? TripPhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(image: photos[indexPath.item])
        return cell
    }
}
