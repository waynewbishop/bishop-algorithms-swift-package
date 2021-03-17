//
//  Card.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation


protocol Playable {
    //functions that use cards..
    //func deal
    //func ante
}

protocol BlackJack : Playable {
    //functions that use cards..
}

protocol Poker : Playable {
    //functions that use card..
}

 class Card : Comparable {
    
    var suit: String?
    var name: String?
    var score: Int = 0
    //todo: need to list secondary score..optional..
    
    public init(of name: String) {
        self.suit = name
    }
    
    static func <(lhs: Card, rhs: Card) -> Bool {
            return lhs.score < rhs.score //what about secondary score..?
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.score == rhs.score
    }
    
 }
 
