//
//  _ExUICollectionViewDiffableDataSource.swift
//  
//
//  Created by ST21485 on 2021/05/26.
//

import UIKit

class _ExUICollectionViewDiffableDataSource<S: Hashable, I: Hashable>: UICollectionViewDiffableDataSource<S, I> {
    var canMoveItem: ((I) -> Bool)?
    var moveItem: ((I) -> Void)?

    func item(at indexPath: IndexPath) -> I {
        let section = snapshot().sectionIdentifiers[indexPath.section]
        let item = snapshot().itemIdentifiers(inSection: section)[indexPath.item]
        return item
    }

    @objc open override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        canMoveItem?(item(at: indexPath)) ?? false
    }

    @objc open override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveItem?(item(at: sourceIndexPath))
    }
}
