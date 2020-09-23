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

public class Vertex: Equatable {
    
    var tvalue = String()  //todo: extend to a generic type <T: Equatable>
    var neighbors = Array<Edge>()
    var visited: Bool = false
    var lastModified = Date()

   public init() {
        //package support
    }
    
   public init(with name: String) {
       self.tvalue = name
    }
    
    
    public static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.tvalue == rhs.tvalue
    }
    
    
}

