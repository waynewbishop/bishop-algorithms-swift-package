//
//  Protocols.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/1/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation


/**
 Required stored property. Custom `HashSet` and `HashChain` type requirement.
 */

public protocol Indexable: Hashable {
    var asciiRepresentation: Int {get}
}



/**
To determine if items stored in a `Comparable` collection are correctly sorted.
 - Complexity: O(n) - Linear Time.
 */

public protocol Sortable {
    func isSorted<T: Comparable>(_ sequence: Array<T>) -> Bool
}
