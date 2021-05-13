//
//  CallCenter.swift
//  
//
//  Created by Wayne Bishop on 4/20/21.
//

import Foundation

class CallCenter: OperatorDelegate {
    
    var estimate: Int = 0
    var history = Deque<Call>()
    let dispatcher = Queue<Call>()
    let employee = Operator("Wayne")  //todo: how can I support multiple operators?
    //var listOperator: Set<Operator> (include status as enum)
    //threading? Answer calls in parallel?
        
    init() {
        //set the delegate
        employee.delegate = self
    }

    
    /*
    note: notice how the action is independent of operators receiving
     and processing calls from the dispatch queue.
    */
    
    func newCall(from name: String) {
        
        let caller = Call(name)
        dispatcher.enQueue(caller)
    }
    
    func requestNextCall(operator: Operator) {
        
        if let item = dispatcher.deQueue() {
            employee.receiveNextCall(item)
        }
    }
    
    //MARK: Delegate Methods
    
    func didProcessCall(employee: Operator, item: Call) {
       
        //add the completed call to audit log
        history.prepend(item)
        
        /*
         note: now that the operator isn't active, request
         and process a new call
         */
        
        //self.requestNextCall()
    }
    
}
