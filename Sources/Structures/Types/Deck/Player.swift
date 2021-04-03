//
//  Player.swift
//  
//
//  Created by Wayne Bishop on 3/17/21.
//

import Foundation

public class Player : Equatable {
    
    let name: String
    var hand = Heap<Card>(type: .Max)  //note: the hand is based on a max-heap
    let uuid = UUID()
    var isDealer: Bool = false //todo: provide different rules if they are the dealer..

    //assign player name
    public init(with name: String) {
        self.name = name
    }
    
    //equatable conformance
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.uuid == rhs.uuid
    }
            
}
