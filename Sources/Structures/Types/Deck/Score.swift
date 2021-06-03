//
//  Score.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation


/// Serves as a basis of comparision for generic cards.

class Score : Equatable {
    
    var name: String //A
    var value: Int  //1
    var secondary: Int?  //11  //todo: wildcard...

    public init(_ name: String = "", _ value: Int = 0, _ secondary: Int? = nil) {
        
        self.name = name
        self.value = value
        self.secondary = secondary
    }
    
    
    //test primary and seconday scores
    static public func == (lhs: Score, rhs: Score) -> Bool {
        return lhs.value == rhs.value
            && lhs.secondary == rhs.secondary
    }
        
}
