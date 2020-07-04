//
//  Peer.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 06/08/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation


    /**
    A participating member of a blockchain network. Peers send and receive funds from other `Members` through  `Exchange` records.
     */

class Peer: Member {

    var blockchain = LinkedList<Block>()
    var audit = Stack<Audit>()
    var desc: String?
    var id: UUID

        
    /**
     Peers objects do not store a `balance` as a stored property, but calcuate this amount a runtime by iterating through the network `Blockchain`.
     
     - Parameter amount: The amount of the initial transaction.
     - Parameter desc: Optional
     - Parameter model: A reference to the `Blockchain` network.
     
     */

    init(amount: Float = 0.0, desc: String = "", model: inout Blockchain){
        
        self.blockchain = model.currentChain()
        self.desc = desc
        self.id = UUID()
        
        let sTrans = Exchange(nil, self, amount, "starting transaction..", .bank)
        model.newExchange(sTrans)

        
        //add reference to network
        model.newMember(item: self)
        
    }
        
    
    /**
     A pending `Exchange` initiated from a Blockchain network `Peer`.
     
     - Parameter from: The `Member` that originated the `Exchange`.
     - Parameter to: The intended `Member` recipient.
     - Parameter for: The amount of the `Exchange`.
     - Parameter desc: Optional
     - Parameter model: A reference to the `Blockchain` network.
     */
    
    func intent(from: Member?, to recipient: Member, for amount: Float, desc: String?,
                model: inout Blockchain) {
        

        //publish exchange to model
        let exchange = Exchange(from, recipient, amount, desc, .peer)
        model.newExchange(exchange)
                
    }
    
    
}


