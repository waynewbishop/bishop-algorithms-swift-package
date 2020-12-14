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

public class Vertex : Equatable {
    
    //todo: public class Vertex <T> : Equatable {}
    
    var tvalue = String()  //todo: change to generic placeholder T
    var neighbors = Array<Edge>()
    var rank: Array<Float> = [0, 0, 0]
    var visited: Bool = false
    var lastModified = Date()
    let uuid = UUID()

   public init() {
        //package support
    }
    
   public init(with name: String) {
       self.tvalue = name
    }
    
    
    //equatable conformance
    public static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
}

