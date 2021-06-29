//
//  File.swift
//  
//
//  Created by Wayne Bishop on 6/21/21.
//

import Foundation

/**
  A participating member in a `Knowledge Graph` data structure.
 */

public class Entity <T: Hashable> : Hashable {
        
    var tvalue: T?
    var neighbors = Array<Fact<T>>() //outbound connection..
    var connections = Set<Entity>() //represent inbound connections
    let uuid = UUID()

   public init() {
        //package support
    }
    
   public init(_ name: T) {
       self.tvalue = name
    }
    
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(tvalue)
    }
    
    //equatable conformance
    public static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.tvalue == rhs.tvalue
    }
    
}
