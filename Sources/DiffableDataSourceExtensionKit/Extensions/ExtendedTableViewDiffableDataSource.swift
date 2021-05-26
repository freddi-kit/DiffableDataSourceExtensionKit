//
//  ExtendedTableViewDiffableDataSource.swift
//
//
//  Created by freddi on 2021/05/25.
//

import UIKit

public class ExtendedTableViewDiffableDataSource<Section>: UITableViewDiffableDataSource<Section, Section.ItemType>, UITableViewDelegate where Section: Sectionable {

    public var didSelectItem: ((Section.ItemType) -> Void)?
    public var deletedItem: ((Section.ItemType) -> Void)?

    public override init(tableView: UITableView,
         cellProvider: @escaping (UITableView, IndexPath, Section.ItemType) -> UITableViewCell?) {
        super.init(tableView: tableView, cellProvider: cellProvider)
    }

    public func item(at indexPath: IndexPath) -> Section.ItemType {
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
}
