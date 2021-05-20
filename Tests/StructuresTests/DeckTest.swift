//
//  DeckTest.swift
//  
//
//  Created by Wayne Bishop on 3/11/21.
//

import XCTest

@testable import Structures


class DeckTest: XCTestCase {
    
    func testBlackJack() {
        
        var blackjack = Blackjack()
        
        /*
         note: with a new game started, check the
         to ensure the card deck has been shuffled.
         */
        
        for card in blackjack.deck.cards.elements {
            print("\(card.score.name) of \(card.suit.name)..")
        }
        
    
        var sruti = Player(with: "Sruti")
        var wayne = Player(with: "Wayne")
        
        
        //feature of the protocol
        blackjack.addPlayer(&sruti)
        blackjack.addPlayer(&wayne)
        
        //start the game
        blackjack.start()
        
        
    }

    
    
    func testHearts() {
        
        var hearts = Hearts()
        
        /*
         note: adding new players is part of the
         Playable protocol
         */
        
        var larry = Player(with: "Larry")
        var sergi = Player(with: "Sergi")
        
        hearts.addPlayer(&larry)
        hearts.addPlayer(&sergi)
        
    }
        
    
    func testRegularDeck() {
            
        /*
        
        let deck = Deck()
        
        //create cards - based on suit templates
        
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
        */
        
    }

}

