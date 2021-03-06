//
//  Itemable.swift
//  
//
//  Created by freddi on 2021/05/25.
//

import Foundation

public protocol Itemable {
    associatedtype IndentityType: Hashable
    var identity: IndentityType { get }
}

struct ItemContainer<Item: Itemable>: Hashable {
    var item: Item

    public func hash(into hasher: inout Hasher) {
        hasher.combine(item.identity)
    }

    public static func == (lhs: ItemContainer<Item>, rhs: ItemContainer<Item>) -> Bool {
        lhs.item.identity == rhs.item.identity
    }
}
