//
//  Path.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 8/4/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
 The `Path` class maintains objects that comprise the `frontier`. 
 */

public class Path <T> {
    
    var total: Int
    var destination: Vertex<T>
    var previous: Path?

    
    //object initialization
    public init(){
        destination = Vertex<T>()
        total = 0
    }
    
}

