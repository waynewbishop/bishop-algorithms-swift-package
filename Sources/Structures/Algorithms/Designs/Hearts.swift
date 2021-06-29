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
    var discard = Stack<Card>()
    
    //todo: needed state machine?
    //deck of cards, suit to match, who's turn it is..
    //can this be established as a delegate..
    
    
    //MARK: Playable protocol conformance
    
    func start() {
        
        deck.shuffle()
        self.hasStarted = true
    }

    
    //deal cards to player
    func deal(_ player: inout Player) {  //todo: pass all playrers as a collection.. pass in from self.players
        
        //assign two cards to the designated player
        for _ in 0..<5 {
            if let card = deck.cards.pop() {
                player.hand.enQueue(card)
            }
        }
    }
    

    //put down a card
    @discardableResult func play(_ player: inout Player, card: Card?) -> Game.Hearts.Turn {
            
        guard let tcard = card else {
            self.draw(&player)
            return .draw
        }
    
        
        //only occurs at game start
        guard discard.count != 0 else {
            discard.push(tcard)
            return .match
        }
        
        
        //todo: what about the hearts wildcard (change the suit).
        
        //todo: can we set up helper indicators as to which cards
        //from their hand to use for the next turn?
        
        if let faceCard = discard.peek() {
            if faceCard.score == tcard.score || faceCard.suit == tcard.suit {
                discard.push(tcard)
                return .match
            }
            else {
                //player keeps the non-matching card
                player.hand.enQueue(tcard)
                self.draw(&player)
                return .nomatch
            }
        }
       
        return .match
    }
    
    
    //receive a card
    func draw(_ player: inout Player)  {
        
        //assigned card
        if let card = deck.cards.pop() {
            player.hand.enQueue(card)
        }
    }

    
    //remove player from game
    func fold(_ player: inout Player) {
        
        if let index = players.firstIndex(of: player) {
            players.remove(at: index)
        }
        
        //todo: where does the players card's go?
        //expired cards stack?
    }

    
    //analyze and complete game
    func call() -> Player? {
        
        //review all players hands to determine a winner.
        for p in players {
            if p.hand.count == 0 {
                return p
            }
        }
        
        return nil
    }
            
    
}
