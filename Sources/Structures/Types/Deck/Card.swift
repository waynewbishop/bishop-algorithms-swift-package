//
//  Card.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation


 public class Card : Comparable {
    
    var suit: Suit
    var score: Score
    
    
    public init() {
        self.suit = Suit()
        self.score = Score()
    }
            
    
    static public func <(lhs: Card, rhs: Card) -> Bool {
        return lhs.score.value < rhs.score.value
    }
    
    //test primary and seconday scores
    static public func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.score.value == rhs.score.value
            && lhs.score.secondary == rhs.score.secondary
    }
    
 }
 
