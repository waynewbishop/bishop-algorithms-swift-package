//
//  Protocols.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/1/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation


/// conformance ruls for all playable games

public protocol Playable {
    
    var players: Array<Player> { get set }
    var hasStarted: Bool { get set }
    var deck: Deck { get }
    
    func start() ->()
    func call() -> Player?
    func deal(_ player: inout Player) ->()
    func draw(_ player: inout Player) ->()
    func fold(_ player: inout Player) ->()
}




///  Used in a blockchain network, `Peers` and `Miners` both conform to this protocol.
///  The conformance of `balance` is implemented through the `Member` protocol extension.

public protocol Member {
    
    var blockchain: LinkedList<Block> {get}
    var desc: String? {get}
    var id: UUID {get}
    var bal: Float {get}
}


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
