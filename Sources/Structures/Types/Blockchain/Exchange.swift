//
//  Exchange.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 2/2/18.
//  Copyright © 2018 Arbutus Software Inc. All rights reserved.
//

import Foundation

    /**
    Records pending and completed transactions between network members. New records are assumed to be in `pending` status, which are eventually fufilled by `Miners`.
     */

public class Exchange {
    
    var from: Member?
    var to: Member
    var amount: Float
    var desc: String?
    var miner: Miner?
    var lastModified: Date
    var type: BTransType

    
    //class initialization
    public init(_ from: Member? = nil , _ to: Member, _ amount: Float, _ desc: String?, _ type: BTransType) {
        
        self.from = from
        self.to = to
        self.amount = amount
        self.desc = desc
        self.lastModified = Date()
        self.type = type
    }
    
}

