//
//  ExtendedCollectionViewDiffableDataSource.swift
//  
//
//  Created by freddi on 2021/05/25.
//

import UIKit

public class ExtendedCollectionViewDiffableDataSource<Section> where Section: Sectionable {

    public var canMoveItem: ((Section.ItemType) -> Bool)?
    public var moveItem: ((Section.ItemType) -> Void)?

    private let dataSource: _ExUICollectionViewDiffableDataSource<SectionContainer<Section>, ItemContainer<Section.ItemType>>

    public init(collectionView: UICollectionView,
         cellProvider: @escaping (UICollectionView, IndexPath, Section.ItemType) -> UICollectionViewCell?) {
        dataSource = .init(collectionView: collectionView) { (collectionView, indexPath, container) -> UICollectionViewCell? in
            return cellProvider(collectionView, indexPath, container.item)
        }

        dataSource.canMoveItem = { [weak self] in
            self?.canMoveItem?($0.item) ?? false
        }

        dataSource.moveItem = { [weak self] in
            self?.moveItem?($0.item)
        }
    }

    public func item(at indexPath: IndexPath) -> Section.ItemType {
        return dataSource.item(at: indexPath).item
    }

    public func apply(with sections: [Section], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionContainer<Section>, ItemContainer<Section.ItemType>>()
        snapshot.appendSections(sections.map(SectionContainer.init))
        sections.forEach { snapshot.appendItems($0.items.map(ItemContainer.init), toSection: SectionContainer(section: $0)) }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
