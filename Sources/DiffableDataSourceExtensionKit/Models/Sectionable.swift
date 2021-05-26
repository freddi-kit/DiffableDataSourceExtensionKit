//
//  Sectionable.swift
//  
//
//  Created by freddi on 2021/05/25.
//

import Foundation

public protocol Sectionable {
    associatedtype ItemType: Itemable
    associatedtype IndentityType: Hashable

    var identity: IndentityType { get set }
    var items: [ItemType] { get }
}

public struct SectionContainer<Section: Sectionable>: Hashable {

    var section: Section

    public func hash(into hasher: inout Hasher) {
        hasher.combine(section.identity)
    }

    public static func == (lhs: SectionContainer<Section>, rhs: SectionContainer<Section>) -> Bool {
        lhs.section.identity == rhs.section.identity
    }
}

