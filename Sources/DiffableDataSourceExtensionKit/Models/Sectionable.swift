//
//  Sectionable.swift
//  
//
//  Created by freddi on 2021/05/25.
//

import Foundation

public protocol Sectionable where Self: Hashable {
    associatedtype ItemType: Itemable
    associatedtype IndentityType: Hashable

    var identity: IndentityType { get set }
    var items: [ItemType] { get }
}

extension Sectionable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identity)
    }
}
