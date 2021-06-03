//
//  CallCenterTwo.swift
//  
//
//  Created by Wayne Bishop on 5/12/21.
//

import Foundation

public class CallCenterTwo : CallCenterDelegate {
            
    var estimate: Int = 0
    var history = Deque<Call>()
    let dispatcher = Queue<Call>()
    let operators = Queue<Operator>() //would an array work better?
    
    
    /// Add new calls to the system
    /// - Parameter name: representation of the caller
    
    func newCall(from name: String) {
        
        dispatcher.enQueue(Call(name))
        
        //check call queue
        self.processNextCall()
    }
        
    
    /// Add new call operator to the system
    /// - Parameter name: representation of the operator
    
   
    
    func newOperator(_ name: String) {
        
        let employee = Operator(name)
        operators.enQueue(employee)
        
        //listen for call completion responses
        employee.delegate = self
        
        //check call queue
        self.processNextCall()
    }
    
    
    func processNextCall() {

        if let nextEmployee = operators.deQueue() {
            
            //todo: check for employee status
            //obtain the next employee from the queue if unavailable..
            
            if let call = dispatcher.deQueue() {
                nextEmployee.receiveNextCall(call)
            }
            else {
                operators.enQueue(nextEmployee)
            }
        }
    }
    
    
    //MARK: Delegate Methods
        
    func didProcessCall(employee: Operator, item: Call) {
       
        //add to audit log
        history.prepend(item)

        //make employee available
        operators.enQueue(employee)
        
        //check call queue
        self.processNextCall()
    }
}
