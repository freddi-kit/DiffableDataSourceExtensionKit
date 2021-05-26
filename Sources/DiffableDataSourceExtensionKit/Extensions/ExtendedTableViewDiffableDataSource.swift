//
//  ExtendedTableViewDiffableDataSource.swift
//
//
//  Created by freddi on 2021/05/25.
//

import UIKit

public class ExtendedTableViewDiffableDataSource<Section> where Section: Sectionable {

    private let dataSource: _ExUITableViewDiffableDataSource<SectionContainer<Section>, ItemContainer<Section.ItemType>>

    public init(tableView: UITableView,
         cellProvider: @escaping (UITableView, IndexPath, Section.ItemType) -> UITableViewCell?) {
        dataSource = .init(tableView: tableView) { (tableView, indexPath, container) -> UITableViewCell? in
            return cellProvider(tableView, indexPath, container.item)
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
