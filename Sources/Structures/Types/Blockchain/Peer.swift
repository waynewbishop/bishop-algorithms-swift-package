//
//  Peer.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 06/08/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation


class Peer: Member {

    
   internal var desc: String?
   internal var audit = Stack<Audit>()
   var blockchain = LinkedList<Block>()
    
    
    //TODO: change to amount..
    //TODO: system to provide UUID as description upon login..
    //TODO: ability to check valid accounts from blockchain?

    
    //add references to main network
    init(balance: Float = 0.0, desc: String = "", model: inout Blockchain){
        
        self.blockchain = model.currentChain()
        self.desc = desc
        
        
        let sTrans = Exchange(nil, self, balance, "starting transaction..")
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


