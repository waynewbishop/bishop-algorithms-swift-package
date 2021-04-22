//
//  Operator.swift
//  
//
//  Created by Wayne Bishop on 4/21/21.
//

import Foundation

//set conforming rules
protocol OperatorDelegate {
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

/*
 //set conforming rules
 protocol IEngineDelegate {
     func willProcessContent(message: String)
     func didProcessContent(results: Int)
 }
 class IEngine {
     //create protocol instance
     var delegate: IEngineDelegate?
     //replicate long running process
     func processContent(_ element: Int) {
         //send initiation message
         delegate?.willProcessContent(message: "engine processing successfully initiated..")
         //perform some basic test operation
         let output = element * 2
         /*
          note: In a real application, this content processing could be executed
          on a background thread through GCD or some other multithreaded execution.
          */
         sleep(2)
         //send message (on main thread)
         delegate?.didProcessContent(results: output)
     }
 }

 */
