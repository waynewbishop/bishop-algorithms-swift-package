//
//  HashSet.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 5/18/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation


/**
Example of a Hash Table. This example replicates the base functionality of a native Swift `Set` collection and does not support hash collisions.
 
 - Complexity: Average time of O(1) - constant time.
 */

public class HashSet <T: Indexable> {
 
    private var buckets: Array<T?>
    private var slots: Int = 0
    
    
    public init(capacity: Int = 20) {
        
        self.buckets = Array<T?>(repeatElement(nil, count: capacity))
        self.slots = buckets.capacity
    }
    

    //O(1) - constant time
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
            //separate chaining..
        }
        
      return false
    }
    
    
    //O(1) - constant time
    public func contains(_ element: T) -> Bool { //O(1) - constant time.
        
      //compute hash value
      let hvalue = self.hash(element)
      
      guard buckets[hvalue] != nil else {
        return false
      }
                                
      return true
    }
    
    
    //unconditional insert
    public func update(_ element: T) -> Bool {
        let result: Bool = self.insert(element)
        return result
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

