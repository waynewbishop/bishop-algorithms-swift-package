//
//  Score.swift
//  
//
//  Created by Wayne Bishop on 3/10/21.
//

import Foundation


/// Serves as a basis of comparision for generic cards.

class Score {
    
    var name: String
    var value: Int
    var secondary: Int?

    public init(_ name: String, _ value: Int, _ secondary: Int? = nil) {
        
        self.name = name
        self.value = value
        self.secondary = secondary
    }
    
}
