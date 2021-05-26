//
//  ExtendedCollectionViewDiffableDataSource.swift
//
//
//  Created by freddi on 2021/05/25.
//

import UIKit

public class ExtendedTableViewDiffableDataSource<Section>: UITableViewDiffableDataSource<SectionContainer<Section>, ItemContainer<Section.ItemType>>, UITableViewDelegate where Section: Sectionable {

    public var didSelectItem: ((Section.ItemType) -> Void)?
    public var deletedItem: ((Section.ItemType) -> Void)?

    public init(tableView: UITableView,
         cellProvider: @escaping (UITableView, IndexPath, Section.ItemType) -> UITableViewCell?) {
        super.init(tableView: tableView) { (tableView, indexPath, container) -> UITableViewCell? in
            return cellProvider(tableView, indexPath, container.item)
        }
        tableView.delegate = self
    }

    private func getCurentItem(at indexPath: IndexPath) -> Section.ItemType {
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

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem?(getCurentItem(at: indexPath))
    }
}
