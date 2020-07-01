//
//  Miner.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/1/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation


    /**
    A blockchain `member` that fulfills pending `Exchange` initiated by `Peers`.

     - Complexity: O(n) - linear time.
     */

class Miner: Member {
    
    
      var blockchain = LinkedList<Block>()
      var desc: String?
      var id: UUID

    
    init(balance: Float = 0.0, desc: String = "", model: inout Blockchain) {
        
        self.desc = desc
        self.id = UUID()
        self.blockchain = model.currentChain()
        
        
        //TODO: enum for transaction type..

        
        let sBalance = Exchange(nil, self, balance, "starting balance..")
        model.newExchange(sBalance)

               
        //send reference
        model.newMember(item: self)
        
    }
        
    
    /**
    Miners `poll` for pending exchange records

     - Parameter model: A reference to a Blockchain network.
     - Complexity: O(n) - linear time.
     */

   func poll(model: inout Blockchain) {
       
    
        //obtain pending exchanges
        let plist = model.exchangeList(requester: self)

    
        if plist.count > 0 {

            
            //add audit to transactions
            for trans in plist {
                trans.miner = self
            }
            
            
            //mine new block
            let newblock = self.mineBlock()
            
            
            newblock.transactions = plist
            newblock.miner = self
            newblock.description = "test block.."
            
            
            model.updateChain(with: newblock)

            
            //clear processed transactions..
            model.clearExchange(requester: self)

            
            //receive reward
            let amount = model.sendreward(to: self)

            
            //publish intent
            let reward = Exchange(nil, self, amount, "mining reward..")
            model.newExchange(reward)
            
        }
        
    }
    
    
    
    
    //mine a new block - the miner does this as part of their local instance..
    private func mineBlock() -> Block {
        return Block()
    }
        
    
}

