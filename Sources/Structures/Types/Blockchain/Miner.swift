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
        
                
        let sBalance = Exchange(nil, self, balance, "starting balance..", .bank)
        model.newExchange(sBalance)

               
        //send reference
        model.newMember(item: self)
        
    }


    
    //TODO: Refactor poll to support desc for new block..
    
    /**
    Miners `poll` for pending exchange records within the network. Once obtained, a new `Block` mined with

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
                newblock.desc = "test block.."
                
                
                model.updateChain(with: newblock)

                
                //clear processed transactions..
                model.clearExchange(requester: self)

                
                //receive reward
                let amount = model.sendreward(to: self)

                
                //publish intent
                let reward = Exchange(nil, self, amount, "mining reward..", .reward)
                model.newExchange(reward)
                
            }
        
    }
    
    
    
   
    //TODO: Refactor poll to support desc for new block..
    
    /**
    Miners `poll` for pending exchange records within the network. Once obtained, a new `Block` mined with

     - Parameter model: A reference to a Blockchain network.
     - Complexity: O(n) - linear time.
     */
    
    private func mineBlock() -> Block {
        print("mining new block..")
        return Block()
    }
        
    
}

