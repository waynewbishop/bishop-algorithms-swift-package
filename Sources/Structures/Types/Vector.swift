//
//  Vector.swift
//  
//
//  Created by Wayne Bishop on 12/22/20.
//

import Foundation

class Vector : Equatable {
    
    var x: Int
    var y: Int
     
    //class initialization
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    //equatable conformance
    public static func == (lhs: Vector, rhs: Vector) -> Bool {
        return (lhs.x == lhs.x) && (lhs.y == rhs.y)
    }
    
    
}
