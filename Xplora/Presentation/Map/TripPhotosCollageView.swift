//
//  TripPhotosCollageView.swift
//  Xplora


import SnapKit
import UIKit

final class TripPhotosCollageView: UIView {
    enum CollageLayoutStyle {
        case one
        case two
        case three
        case four
        case five
        case six
        case sevenToNine
        case tenPlus

        static func style(for count: Int) -> CollageLayoutStyle {
            switch count {
            case 0...1: return .one
            case 2: return .two
            case 3: return .three
            case 4: return .four
            case 5: return .five
            case 6: return .six
            case 7...9: return .sevenToNine
            default: return .tenPlus
            }
        }
    }

    private let containerView = UIView()
    private let collectionView: UICollectionView
    private var images: [UIImage] = []
    private var layoutStyle: CollageLayoutStyle = .one
    private var displayCount: Int = 0
    private var extraCount: Int = 0

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

    func configure(images: [UIImage]) {
        self.images = images
        layoutStyle = CollageLayoutStyle.style(for: images.count)
        let maxDisplay = layoutStyle == .tenPlus ? 5 : 10
        displayCount = min(images.count, maxDisplay)
        extraCount = max(0, images.count - displayCount)
        collectionView.setCollectionViewLayout(makeLayout(style: layoutStyle, count: displayCount), animated: false)
        collectionView.isHidden = images.isEmpty
        collectionView.reloadData()
    }

    private func setupView() {
        backgroundColor = .clear

        containerView.layer.cornerRadius = 14
        containerView.clipsToBounds = true
        containerView.backgroundColor = .clear
        addSubview(containerView)

        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(TripPhotosCollageCell.self, forCellWithReuseIdentifier: TripPhotosCollageCell.reuseIdentifier)
        containerView.addSubview(collectionView)

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func makeLayout(style: CollageLayoutStyle, count: Int) -> UICollectionViewLayout {
        let spacing: CGFloat = 2
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: spacing / 2, leading: spacing / 2, bottom: spacing / 2, trailing: spacing / 2)

            switch style {
            case .one:
                return TripPhotosCollageView.makeOneSection(item: item)
            case .two:
                return TripPhotosCollageView.makeTwoSection(item: item)
            case .three:
                return TripPhotosCollageView.makeThreeSection(item: item)
            case .four:
                return TripPhotosCollageView.makeFourSection(item: item)
            case .five:
                return TripPhotosCollageView.makeFiveSection(item: item)
            case .six:
                return TripPhotosCollageView.makeSixSection(item: item)
            case .sevenToNine:
                return TripPhotosCollageView.makeSevenToNineSection(item: item, count: count)
            case .tenPlus:
                return TripPhotosCollageView.makeTenPlusSection(item: item)
            }
        }
        return layout
    }

    private static func makeOneSection(item: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitems: [item]
        )
        return NSCollectionLayoutSection(group: group)
    }

    private static func makeTwoSection(item: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitem: item,
            count: 2
        )
        return NSCollectionLayoutSection(group: group)
    }

    private static func makeThreeSection(item: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let rightItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
        rightItem.contentInsets = item.contentInsets

        let rightGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(0.34), heightDimension: .fractionalHeight(1.0)),
            subitem: rightItem,
            count: 2
        )

        let leftGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(1.0)),
            subitems: [item]
        )

        let container = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitems: [leftGroup, rightGroup]
        )
        return NSCollectionLayoutSection(group: container)
    }

    private static func makeFourSection(item: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let midItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
        midItem.contentInsets = item.contentInsets

        let midGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(0.22), heightDimension: .fractionalHeight(1.0)),
            subitem: midItem,
            count: 2
        )

        let rightGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.23), heightDimension: .fractionalHeight(1.0)),
            subitems: [item]
        )

        let leftGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.55), heightDimension: .fractionalHeight(1.0)),
            subitems: [item]
        )

        let container = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitems: [leftGroup, midGroup, rightGroup]
        )
        return NSCollectionLayoutSection(group: container)
    }

    private static func makeFiveSection(item: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let rightItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5)))
        rightItem.contentInsets = item.contentInsets

        let rightRow = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)),
            subitem: rightItem,
            count: 2
        )

        let rightGrid = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(0.34), heightDimension: .fractionalHeight(1.0)),
            subitems: [rightRow, rightRow]
        )

        let leftGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(1.0)),
            subitems: [item]
        )

        let container = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitems: [leftGroup, rightGrid]
        )
        return NSCollectionLayoutSection(group: container)
    }

    private static func makeSixSection(item: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let leftTop = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.66)),
            subitems: [item]
        )

        let leftBottomItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        leftBottomItem.contentInsets = item.contentInsets
        let leftBottom = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.34)),
            subitem: leftBottomItem,
            count: 2
        )

        let leftColumn = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(1.0)),
            subitems: [leftTop, leftBottom]
        )

        let rightTop = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.33)),
            subitems: [item]
        )

        let rightBottomItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        rightBottomItem.contentInsets = item.contentInsets
        let rightBottom = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.67)),
            subitem: rightBottomItem,
            count: 2
        )

        let rightColumn = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(0.34), heightDimension: .fractionalHeight(1.0)),
            subitems: [rightTop, rightBottom]
        )

        let container = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitems: [leftColumn, rightColumn]
        )
        return NSCollectionLayoutSection(group: container)
    }

    private static func makeSevenToNineSection(item: NSCollectionLayoutItem, count: Int) -> NSCollectionLayoutSection {
        let topRightItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        topRightItem.contentInsets = item.contentInsets
        let topRightRow = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitem: topRightItem,
            count: 2
        )

        let heroGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(1.0)),
            subitems: [item]
        )

        let topRow = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.58)),
            subitems: [heroGroup, NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.34), heightDimension: .fractionalHeight(1.0)), subitems: [topRightRow])]
        )

        let bottomLeftItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        bottomLeftItem.contentInsets = item.contentInsets
        let bottomLeftRow = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitem: bottomLeftItem,
            count: 2
        )

        let bottomRightGroup: NSCollectionLayoutGroup
        switch count {
        case 7:
            let tallItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
            tallItem.contentInsets = item.contentInsets
            bottomRightGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
                subitem: tallItem,
                count: 2
            )
        case 8:
            let gridItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5)))
            gridItem.contentInsets = item.contentInsets
            let topRow = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)),
                subitem: gridItem,
                count: 2
            )
            let bottomRow = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)),
                subitems: [gridItem]
            )
            bottomRightGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
                subitems: [topRow, bottomRow]
            )
        default:
            let gridItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5)))
            gridItem.contentInsets = item.contentInsets
            let row = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)),
                subitem: gridItem,
                count: 2
            )
            bottomRightGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
                subitems: [row, row]
            )
        }

        let bottomRow = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.42)),
            subitems: [
                NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(1.0)), subitems: [bottomLeftRow]),
                NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.34), heightDimension: .fractionalHeight(1.0)), subitems: [bottomRightGroup])
            ]
        )

        let container = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitems: [topRow, bottomRow]
        )
        return NSCollectionLayoutSection(group: container)
    }

    private static func makeTenPlusSection(item: NSCollectionLayoutItem) -> NSCollectionLayoutSection {
        let rightItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5)))
        rightItem.contentInsets = item.contentInsets
        let row = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)),
            subitem: rightItem,
            count: 2
        )
        let rightGrid = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(0.34), heightDimension: .fractionalHeight(1.0)),
            subitems: [row, row]
        )
        let leftGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.66), heightDimension: .fractionalHeight(1.0)),
            subitems: [item]
        )
        let container = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
            subitems: [leftGroup, rightGrid]
        )
        return NSCollectionLayoutSection(group: container)
    }
}

extension TripPhotosCollageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripPhotosCollageCell.reuseIdentifier, for: indexPath) as? TripPhotosCollageCell else {
            return UICollectionViewCell()
        }
        let image = images[indexPath.item]
        let isLast = indexPath.item == displayCount - 1
        let shouldShowOverlay = layoutStyle == .tenPlus && extraCount > 0 && isLast
        cell.configure(image: image, overflowCount: shouldShowOverlay ? extraCount : 0)
        return cell
    }
}
