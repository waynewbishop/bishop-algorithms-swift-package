//
//  Event.swift
//  
//
//  Created by Wayne Bishop on 2/26/21.
//

import Foundation

//to be used when recording generic events

public class Event <T: Equatable> {
    
    var tvalue: T?
    var date: Date
    
    public init(_ tvalue: T) {
        
        self.tvalue = tvalue
        self.date = Date()
    }

}
