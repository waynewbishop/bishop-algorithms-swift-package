//
//  Protocols.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/1/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation


/**
 Used in a blockchain network, `Peers` and `Miners` both conform to this protocol. The conformance of `balance` is implemented through the `Member` protocol extension.
 */

protocol Member {
    
    var blockchain: LinkedList<Block> {get}
    var desc: String? {get}
    var id: UUID {get}
    var bal: Float {get}
}



//define stored property - hashSet requirement
protocol Indexable {
    var asciiRepresentation: Int {get}
}



//determine sort order
protocol Sortable {
    func isSorted<T: Comparable>(_ sequence: Array<T>) -> Bool
}
