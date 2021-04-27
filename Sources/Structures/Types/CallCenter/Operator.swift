//
//  Operator.swift
//  
//
//  Created by Wayne Bishop on 4/21/21.
//

import Foundation

//set conforming rules
protocol OperatorDelegate {
  //todo: func willReceiveCall(employee: Operator, item: Call) -> ()
    func didProcessCall(employee: Operator, item: Call) -> ()
}

class Operator {
    
    //create protocol instance
    var delegate: OperatorDelegate?
    let uuid = UUID()
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    
    func receiveNextCall(_ item: Call) -> () {
        
        sleep(2)
        
        item.notes = "Nice speaking with you \(item.name)."
        item.receivedCall = self
        item.isCompleted = true
        
        //post message
        if let delegator = delegate {
            delegator.didProcessCall(employee: self, item: item)
        }
        
    }
    
}
