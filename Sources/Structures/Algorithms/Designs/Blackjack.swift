//
//  Blackjack.swift
//  
//
//  Created by Wayne Bishop on 3/17/21.
//

import Foundation

class Blackjack : Playable {
    
    var players = Array<Player>()
    var deck = Deck()
    var discard = Array<Card>()
    var hasStarted: Bool = false
    
    
    //MARK: Playable protocol conformance
    
    func start() {
        
        //randomize the deck
        deck.shuffle()
        self.hasStarted = true
    }
    
    //deal cards to player
    func deal(_ player: inout Player) {
        
        //assign two cards to the designated player
        for _ in 0..<2 {
            if let card = deck.cards.pop() {
                player.hand.enQueue(card)
            }
        }
        
    }
    

    //put down a card
    func play(_ player: inout Player, card: Card?) -> Turn  {
        
        //do some card analysis here..
        return Turn.match
    }
    
    
    
    //receive a card - could be moved to Playable
    func draw(_ player: inout Player)  {
        
        if let card = deck.cards.pop() {
            player.hand.enQueue(card)
        }
    }
    
    
    func fold(_ player: inout Player) {
        //code goes here..
    }
    
    //analyze and complete game
    func call() -> Player? {
        return nil
    }
    
    
}
