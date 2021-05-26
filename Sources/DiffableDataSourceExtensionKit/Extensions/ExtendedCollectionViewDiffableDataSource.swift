//
//  ExtendedCollectionViewDiffableDataSource.swift
//  
//
//  Created by freddi on 2021/05/25.
//

import UIKit

public class ExtendedCollectionViewDiffableDataSource<Section>: UICollectionViewDiffableDataSource<Section, Section.ItemType>, UICollectionViewDelegate where Section: Sectionable {

    public var didSelectItem: ((Section.ItemType) -> Void)?
    public var deletedItem: ((Section.ItemType) -> Void)?
    public var canMoveItem: ((Section.ItemType) -> Bool)?
    public var moveItem: ((Section.ItemType) -> Void)?

    public override init(collectionView: UICollectionView,
         cellProvider: @escaping (UICollectionView, IndexPath, Section.ItemType) -> UICollectionViewCell?) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)

        collectionView.delegate = self
    }

    private func getCurentItem(at indexPath: IndexPath) -> Section.ItemType {
        let section = snapshot().sectionIdentifiers[indexPath.section]
        let item = snapshot().itemIdentifiers(inSection: section)[indexPath.item]
        return item
    }

    public func apply(with sections: [Section], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Section.ItemType>()
        snapshot.appendSections(sections)
        sections.forEach { snapshot.appendItems($0.items, toSection: $0) }
        apply(snapshot, animatingDifferences: animatingDifferences)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(getCurentItem(at: indexPath))
    }

    @objc open override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        canMoveItem?(getCurentItem(at: indexPath)) ?? false
    }

    @objc open override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveItem?(getCurentItem(at: sourceIndexPath))
    }
}
