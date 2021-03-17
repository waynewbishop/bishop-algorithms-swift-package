//
//  DeckTest.swift
//  
//
//  Created by Wayne Bishop on 3/11/21.
//

import XCTest

@testable import Structures


class DeckTest: XCTestCase {
    
    func testRegularDeck() {
        
        //establish the suits
        let hearts = Suit(of: "Hearts")
        let diamonds = Suit(of: "Diamonds")
        let spades = Suit(of: "Spades")
        let clubs = Suit(of: "Clubs")
                
        let deck = Deck()
        
        //create cards - based on suit templates
        
        //todo: could this be done on an init?
        //todo: could the creation of the deck be done as a protocol?
        
        deck.add(suit: hearts)
        deck.add(suit: diamonds)
        deck.add(suit: spades)
        deck.add(suit: clubs)

        
        //test the card deck contents..
        print("there are: \(deck.cards.count) cards in the deck..")
        
        for card in deck.cards {
            print("\(card.name!) of \(card.suit!)")
        }
        
        //compare two random cards.
        let cardA = deck.cards[5]
        let cardB = deck.cards[37]

        
        /*
         note: two individual cards can compared because the basis for comparision is
         point system independent of the card name. The point sytem is included with each
         suit template
         */
        
        if cardA < cardB {
            print("\(cardA.name!) of \(cardA.suit!) is smaller than \(cardB.name!) of \(cardB.suit!)")
        }
        
    }

}

