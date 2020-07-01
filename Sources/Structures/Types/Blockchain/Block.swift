//
//  Block.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 1/31/18.
//  Copyright © 2018 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
 Tracks groups of completed transactions in a Blockchain network. Each `block` contains one or more `Exchange` which records the sender, recipient, `miner` and amount.
 */

public class Block {
    
    var transactions: Array<Exchange>?
    var miner: Miner?
    var lastModified: Date
    var description: String?
    
    
    //initialize class
    init() {
        self.lastModified = Date()
    }
    
}

