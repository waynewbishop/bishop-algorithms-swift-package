//
//  Deck.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation


public class Deck {

    var cards = SimpleStack<Card>()
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
         notes: simulate dealer taking multiple pairs of cards,
         putting them in random places in the deck.
         */
        
        let cardRange: Range = 0..<cards.count
        
        for _ in 0...cards.count {
            
            //obtain random values
            let first = Int.random(in: cardRange)
            let second = Int.random(in: cardRange)
            
            //swap card positions
            cards.swapAt(lhs: first, rhs: second)
        }
        
    }
    
    
    //remove a card from the deck
    public func draw() -> Card? {
        return self.cards.pop()
    }
    
    
}
