//
//  Playable.swift
//  
//
//  Created by Wayne Bishop on 3/18/21.
//

import Foundation


extension Playable {  //extension of a protocol
    
    
    //new player to a game - regardless of game type
    mutating func newplayer(_ name: String) -> Player {
        
        let player = Player(with: name)
        players.append(player)
        return player
    }

    
    
}
