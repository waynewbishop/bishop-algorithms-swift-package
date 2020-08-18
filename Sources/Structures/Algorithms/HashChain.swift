//
//  HashChain.swift
//  
//
//  Created by Wayne Bishop on 8/18/20.
//

import Foundation


/**
Example of a Hash Table implementation. Demonstrates functionality of hash collisions through the concept of separate chaining.
 
 - Complexity: Best-case O(1) - constant time. Worst-case O(n) - linear time. 
 */

public class HashChain <T: Indexable> {
 
    private var buckets: Array<T?>  //todo: change to support a generic LinkedList algorithm
    private var slots: Int = 0
    
    
    public init(capacity: Int = 20) {
        
        self.buckets = Array<T?>(repeatElement(nil, count: capacity))
        self.slots = buckets.capacity
    }
    

    public func insert (_ element: T) -> Bool {
        
      //compute hash value
      let hvalue = self.hash(element)
        
        if buckets[hvalue] == nil {
            buckets[hvalue] = element
            slots -= 1

            
            //determine if more slots are needed
            if slots == 1 {
                buckets.append(nil)
                slots = 1
            }
            
            return true
        }
        
        else {
            //todo: separate chaining..
            //call LinkedList.append() to add a new generic LLNode to the list.
        }
        
      return false
    }
    
    
    public func contains(element: T) -> Bool {
        /*
         todo: my current LinkedList implementation doesn't support a
         contains function, as generic objects would need to conform to
         Equatable. If you would like to give this try just let me know.
        */
        return false
    }
    
    
    
    private func hash(_ element: T) -> Int {
        
        /*
         conforming indexable objects are required to have an
         ascii representation to be used by the hash algorithm.
         */
        
        var remainder: Int = 0
        remainder = element.asciiRepresentation % buckets.count
        return remainder
    }
    
}
