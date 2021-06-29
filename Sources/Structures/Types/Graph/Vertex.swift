//
//  Vertex.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation


/**
  A participating member in a `Graph` data structure.
 */

public class Vertex <T> : Equatable {
        
    var tvalue: T?
    var neighbors = Array<Edge<T>>()
    var rank: Array<Float> = [0, 0, 0]  //memoization.. //todo: what about a Stack? 
    var visited: Bool = false
    var lastModified = Date()
    let uuid = UUID()  //objectidentifier?
    //todo: var inbound_connections = Array<Vertex<T>>()
    

   public init() {
        //package support
    }
    
   public init(with name: T) {
       self.tvalue = name
    }
    
    
    //equatable conformance
    public static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
}

