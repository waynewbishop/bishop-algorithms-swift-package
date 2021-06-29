//
//  Fact.swift
//  
//
//  Created by Wayne Bishop on 6/21/21.
//

import Foundation


public class Fact <T: Hashable>: Hashable {
    
    var neighbor: Entity<T>
    var token: Token
    
    init() {
        token = .unknown
        self.neighbor = Entity<T>()
    }
    
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(neighbor)
    }
    
    //equatable conformance
    public static func == (lhs: Fact, rhs: Fact) -> Bool {
        return lhs.neighbor == rhs.neighbor
    }
}
