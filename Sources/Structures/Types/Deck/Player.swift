//
//  Player.swift
//  
//
//  Created by Wayne Bishop on 3/17/21.
//

import Foundation

public class Player : Scoreable {
    
    let name: String
    var hand = Heap<Card>(type: .Max)
    var isDealer: Bool = false //todo: provide different rules if they are the dealer..
    
    let uuid = UUID()

    //assign player name
    public init(with name: String) {
        self.name = name
    }
    
    //todo: optional protocol to be used with poker..
    
    var score: Int {
        //gets computed as the hand changes..
        //gets included at the protocol level...
        return 0
    }
    
    
    /// Provides details on showing a players hand
    /// - Returns: nil
    
    public func showHand()->() {
        
        print("Player: \(self.name)")
        print("---------")
        
        for s in self.hand.items {
            print("\(s.suit.name) - \(s.score.name)")
        }
        
        print("")
    }
    

    
    /// Play the selected card based on index
    /// - Returns: A Card (optional)
    public func playCard(index: Int) -> Card?  {
        
        // todo: if self.hand.count >= index
        
        if self.hand.items.indices.contains(index) {
            let playcard = self.hand.items.remove(at: index)
            return playcard
        }
        else {
            return nil
        }
    }
    
    //equatable conformance
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.uuid == rhs.uuid
    }
            
}
