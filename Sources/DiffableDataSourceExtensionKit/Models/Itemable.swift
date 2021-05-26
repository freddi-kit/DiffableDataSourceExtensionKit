//
//  Itemable.swift
//  
//
//  Created by freddi on 2021/05/25.
//

import Foundation

public protocol Itemable where Self: Hashable {
    associatedtype IndentityType: Hashable
    var identity: IndentityType { get }
}

extension Itemable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identity)
    }
}
