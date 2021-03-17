//
//  Deck.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation

public class Deck {

    //the deck of cards
    var cards = Array<Card>()
    
    public init() {
        //package support
    }
    
    //create new cards based on a generic suit
    public func add(suit: Suit) {
        
        /*
         note: scores template generates cards for the entire suit
         */
        for s in suit.scores {
            
            let card = Card(of: suit.name)
            
            card.name = s.name
            card.score = s.value
            card.secondary = s.secondary
            
            //add card to deck
            self.cards.append(card)
        }
        
    }

    
    //randomize all the array values in the deck..
    public func shuffle() {
        /*
         notes: copy the deck array then assign each value
         card to a new random slot between 0 and the remaining
         slots avaiable in the shuffled model.
         */
    }
    
    
    //remove a card from the deck
    public func draw() -> Card? {
        return nil
    }
    
    
}
