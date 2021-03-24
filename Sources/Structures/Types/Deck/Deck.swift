//
//  Deck.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation


public class Deck {

    var cards = Stack<Card>()  //todo should this be a stack!!
    private var suits = Array<Suit>()  //provides card template

    
    public init() {

        suits.append(Suit(of: "hearts"))
        suits.append(Suit(of: "diamonds"))
        suits.append(Suit(of: "spades"))
        suits.append(Suit(of: "clubs"))
    
        
        for suit in suits {
            /*
             note: scores template generates cards for the entire suit
             */
            for s in suit.scores {
                
                let card = Card(of: suit.name)
                
                card.name = s.name
                card.score = s.value
                card.secondary = s.secondary
                
                //push card to deck
                //self.cards.append(card)
                self.cards.push(card)
            }
        }
        
    } //end init
    
    

    
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
        let card = self.cards.popValue()
        return card
    }
    
    
}
