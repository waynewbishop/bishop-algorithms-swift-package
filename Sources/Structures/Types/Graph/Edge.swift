//
//  Edge.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
  Represents the connection between two `Graph` vertices.
 */

public class Edge <T> {
    
    var neighbor: Vertex<T>
    var weight: Int
    
    init() {
        weight = 0
      //  detail = .unknown
        self.neighbor = Vertex<T>()
    }
    
}

