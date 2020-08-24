//
//  LLNode.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
    Generic `linked list` data structure.
 */

public class LLNode <T> {
    
    var tvalue: T?
    var next: LLNode?
    var previous: LLNode?
    
    public init() {
        //playground support
    }
    
}

