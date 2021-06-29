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

        //add players
        hearts.addPlayer(&larry)
        hearts.addPlayer(&sergi)        
        
        //start game and shuffle deck
        hearts.start()
        
        //allocate cards to players
        hearts.deal(&larry)
        hearts.deal(&sergi)
        
        
        //check hand
        larry.showHand()
        sergi.showHand()
        
        //make a play
        hearts.play(&larry, card: larry.playCard(index: 2))

        //make a play
        hearts.play(&sergi, card: larry.playCard(index: 3))
        
    }

}

