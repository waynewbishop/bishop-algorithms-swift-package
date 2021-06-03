//
//  Call.swift
//  
//
//  Created by Wayne Bishop on 4/21/21.
//

import Foundation


/*
 notes: used in the development of a call center design model.
 in a real model, the caller could be associated with a person
 identifier for tracking their call history.
*/

public class Call {

    var name: String
    var receivedCall: Operator?
    var isCompleted: Bool = false
    var notes: String?
    
    let uuid = UUID()
    let date = Date()
    //todo: add additional enqueue and deque dates..
    
    init(_ name: String) {
        self.name = name
    }
    
}
