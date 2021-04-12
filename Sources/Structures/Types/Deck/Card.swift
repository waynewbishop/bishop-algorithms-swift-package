//
//  Card.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation


 public class Card : Comparable {
    
    //todo: these fields are redudant. Can be obtained from the related Suit and Score objects..
    
    var suit: String?
    var name: String?
    var score: Int = 0
    var secondary: Int?
    
    
    public init(of name: String) {
        self.suit = name
    }
    
    static public func <(lhs: Card, rhs: Card) -> Bool {
            return lhs.score < rhs.score //what about secondary score..?
    }
    
    static public func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.score == rhs.score
    }
    
 }
 
