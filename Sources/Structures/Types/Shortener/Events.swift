//
//  Events.swift
//  
//
//  Created by Wayne Bishop on 3/3/21.
//

import Foundation

public class Events <T: Equatable> {
    
    var items: Array<Event<T>>  //todo: change container to Stack - O(1)
    
    init() {
        self.items = Array<Event<T>>()
    }
        
    //new item
    func add(_ tvalue: T) {
        items.append(Event<T>(tvalue))
    }
    
}
