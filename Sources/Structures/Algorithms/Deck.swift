//
//  Deck.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation

class Deck {

    //the deck of cards
    var cards = Array<Card>()
    
    public init() {
        //package support
    }
    
    //create new cards based on a generic suit
    func add(suit: Suit) {
        
        /*
         note: scores template generates cards for the entire suit
         */
        for s in suit.scores {
            
            let card = Card(of: suit.name)
            card.name = s.name
            card.score = s.value
            
            //add card to deck
            self.cards.append(card)
        }
        
    }
    
}
