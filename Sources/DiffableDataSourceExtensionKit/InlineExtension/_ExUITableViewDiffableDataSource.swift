//
//  _ExUITableViewDiffableDataSource.swift
//  
//
//  Created by ST21485 on 2021/05/26.
//

import UIKit

class _ExUITableViewDiffableDataSource<S: Hashable, I: Hashable>: UITableViewDiffableDataSource<S, I> {

    func item(at indexPath: IndexPath) -> I {
        let section = snapshot().sectionIdentifiers[indexPath.section]
        let item = snapshot().itemIdentifiers(inSection: section)[indexPath.item]
        return item
    }
}
