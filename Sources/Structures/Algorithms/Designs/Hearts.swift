//
//  Hearts.swift
//
//
//  Created by Wayne Bishop on 3/17/21.
//

import Foundation

class Hearts : Playable {
    
    var hasStarted: Bool = false
    var players = Array<Player>()
    var deck = Deck()
    var discard = Array<Card>()
    
    
    //MARK: Playable protocol conformance
    
    func start() {
        deck.shuffle()
        self.hasStarted = true
    }

    
    //deal cards to player
    func deal(_ player: inout Player) {
        
        //assign two cards to the designated player
        for _ in 0..<5 {
            if let card = deck.cards.pop() {
                player.hand.enQueue(card)
            }
        }
    }
    

    //put down a card
    func play(_ player: inout Player, _ index: Int) {
        
        /*
         note: since each players hand is a heap,
         we can indicate which card should be discarded by
         selecting the card index value. This 'card' can then
         just be removed, or added to a 'virtual' discard pile.
         */
        
        let card = player.hand.items[index]
        discard.append(card)
        
        //do some card analysis here..
    }
    
    
    //receive a card
    func draw(_ player: inout Player)  {
        
        //assigned card
        if let card = deck.cards.pop() {
            player.hand.enQueue(card)
        }
    }
    
    
    //analyze and complete game
    func call() {
        
    }
    
    
}
