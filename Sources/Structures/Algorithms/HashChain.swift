//
//  HashChain.swift
//  
//
//  Created by Wayne Bishop on 8/18/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation


/**
Example of a Hash Table implementation. Demonstrates functionality of hash collisions through the concept of separate chaining.
 
 - Complexity: Best-case O(1) - constant time. Worst-case O(n) - linear time.
 - Important: Generic chain value
 */

public class HashChain <T: Indexable> {
 
    private var slots: Int = 0
    var buckets: Array<Chain<T>?>

    
    public init(capacity: Int = 20) {
        
        self.buckets = Array<Chain<T>?>(repeatElement(nil, count: capacity))
        self.slots = buckets.capacity
        
    }
    

    public func insert (_ element: T) {
        
      //compute hash value
      let hvalue = self.hash(element)
        
        if buckets[hvalue] == nil {
            
            //new chain
            let chain = Chain<T>()
            chain.append(element)
            
            buckets[hvalue] = chain
            slots -= 1
            
        
            if slots == 1 {
                buckets.append(nil)
                slots = 1
            }
            
        }
        else {
            print("collision detected!")
            
            //use existing chain
            if let chain = buckets[hvalue] {
                if chain.contains(element) == false {
                    chain.append(element)
                }
            }
                
        }
        
    }
    
    
    
     public func contains(_ element: T) -> Bool {
        
      //compute hash value
      let hvalue = self.hash(element)
      
        guard let chain = buckets[hvalue] else {
            return false
        }

      return chain.contains(element)
        
    }
    
    
    
    
     private func hash (_ element: T) -> Int {
        
        /*
         conforming indexable objects are required to have an
         ascii representation to be used by the hash algorithm.
         */
        
        var remainder: Int = 0
        remainder = element.asciiRepresentation % buckets.count
        return remainder
    }
    
}
