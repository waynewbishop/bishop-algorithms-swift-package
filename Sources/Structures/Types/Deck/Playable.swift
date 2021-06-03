//
//  Playable.swift
//  
//
//  Created by Wayne Bishop on 3/18/21.
//

import Foundation


extension Playable {  //extension of a protocol
    
    mutating func addPlayer(_ player: inout Player) {
        if self.hasStarted == false {
            players.append(player)  //reference being added..
        }
    }

}
