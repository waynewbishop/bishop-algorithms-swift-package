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
    
    /*
     note: in addition to the specified based model, an additional
     hasStarted property could also be added at the level preventing
     new players to the model once the game has started.
     */
    
    public init() {
        //package support
    }

    
    //add new player to the game
    func newPlayer(_ name: String) -> Player? {
        return nil
    }

    
    
    //MARK: Playable protocol conformance
    
    
    //deal cards to player
    func deal(_ player: inout Player) {
        
    }
    

    //put down a card
    func play(_ player: inout Player, _ card: Card) {
    }
    
    
    //receive a card
    func draw(_ player: inout Player)  {
        
    }
    
    
    //analyze and complete game
    func call() {
        
    }
    
    
}
