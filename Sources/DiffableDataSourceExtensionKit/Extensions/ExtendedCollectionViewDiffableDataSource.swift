//
//  ExtendedCollectionViewDiffableDataSource.swift
//  
//
//  Created by freddi on 2021/05/25.
//

import UIKit

public class ExtendedCollectionViewDiffableDataSource<Section>: UICollectionViewDiffableDataSource<SectionContainer<Section>, ItemContainer<Section.ItemType>> where Section: Sectionable {

    public var didSelectItem: ((Section.ItemType) -> Void)?
    public var deletedItem: ((Section.ItemType) -> Void)?
    public var canMoveItem: ((Section.ItemType) -> Bool)?
    public var moveItem: ((Section.ItemType) -> Void)?

    public init(collectionView: UICollectionView,
         cellProvider: @escaping (UICollectionView, IndexPath, Section.ItemType) -> UICollectionViewCell?) {
        super.init(collectionView: collectionView) { (collectionView, indexPath, container) -> UICollectionViewCell? in
            return cellProvider(collectionView, indexPath, container.item)
        }
    }

    public func item(at indexPath: IndexPath) -> Section.ItemType {
        let section = snapshot().sectionIdentifiers[indexPath.section]
        let item = snapshot().itemIdentifiers(inSection: section)[indexPath.item]
        return item.item
    }

    public func apply(with sections: [Section], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionContainer<Section>, ItemContainer<Section.ItemType>>()
        snapshot.appendSections(sections.map(SectionContainer.init))
        sections.forEach { snapshot.appendItems($0.items.map(ItemContainer.init), toSection: SectionContainer(section: $0)) }
        apply(snapshot, animatingDifferences: animatingDifferences)
    }

    @objc open override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        canMoveItem?(item(at: indexPath)) ?? false
    }

    @objc open override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveItem?(item(at: sourceIndexPath))
    }
}
