//
//  Vector.swift
//  
//
//  Created by Wayne Bishop on 12/22/20.
//

import Foundation

class Vector: Equatable, CustomStringConvertible {
    
    var x: Int
    var y: Int

    //print conformance
    var description: String {
       return "(\(x), \(y))"
    }
     
    //class initialization
    init(_ x: Int = 0, _ y: Int = 0) {
        self.x = x
        self.y = y
    }
    
    //equatable conformance
    public static func == (lhs: Vector, rhs: Vector) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }

}
