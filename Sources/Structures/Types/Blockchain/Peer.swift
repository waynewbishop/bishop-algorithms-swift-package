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

    
    //TODO: system to provide UUID as description upon login..
    //TODO: ability to check valid accounts from blockchain?

    
    //add references to main network
    init(amount: Float = 0.0, desc: String = "", model: inout Blockchain){
        
        self.blockchain = model.currentChain()
        self.desc = desc
        self.id = UUID()
        
        let sTrans = Exchange(nil, self, amount, "starting transaction..")
        model.newExchange(sTrans)

        
        model.newMember(item: self)
        
    }
    
    
    //TODO: Should this be moved to Member extension??
    //TODO: Does "from" need to be removed?
    
    
    //a pending exchange
    func intent(from: Member?, to recipient: Member, for amount: Float, desc: String?,
                model: inout Blockchain) {
        

        //publish exchange to model
        let exchange = Exchange(from, recipient, amount, desc)
        model.newExchange(exchange)
                
    }
    
    
}


