//
//  Table.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 5/25/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
  Custom genetic structure used with hash tables and priorty queues.
 */

public class Table <T> {
    
    var tvalue: T?
    var count: Int

    //set initializers
   public init(_ tvalue: T, count: Int = 1) {
        
        self.tvalue = tvalue
        self.count = count
    }
    
}
