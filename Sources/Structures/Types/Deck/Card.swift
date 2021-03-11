//
//  Card.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation


 class Card : Comparable {
    
    var suit: String?
    var name: String?
    var score: Int = 0
    
    public init(of name: String) {
        self.suit = name
    }
    
    static func <(lhs: Card, rhs: Card) -> Bool {
            return lhs.score < rhs.score
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.score == rhs.score
    }
    
 }
 
