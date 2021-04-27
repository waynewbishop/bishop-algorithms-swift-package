//
//  Glossary.swift
//  
//
//  Created by Wayne Bishop on 4/27/21.
//

import Foundation


class Glossary <Key: Indexable, Value> {
    
   private var klist = Set<Key>()
   private var vlist = Array<Value?>(repeating: nil, count: 100)

    
    //return keys
    var keys: Array<Key> {
        return Array<Key>(klist)
    }
    
    
    //return values
    var values: Array<Value?> {
        return vlist
    }
    
    //add or update key-value pair
    public func updateValue(_ value: Value, for key: Key) {
        
        //insert, update existing key
        klist.insert(key)
        
        //generate unique hash
        let index = self.hash(key)
        
        //add to bucket list
        vlist[index] = value
    }
    
    
    //remove key-value pair
    public func removeValue(for key: Key) {
            
        //generate unique hash
        let index = self.hash(key)
        
        //reset value at index
        vlist[index] = nil

        //remove related key
        klist.remove(key)
        
    }
    

    //MARK: Closure operations
    
    
    //returns the first index - based on value
    public func firstIndex(formula: (Value) -> Bool) -> Int? {
        
        var results: Int = 0
        
        //find value based on criteria
        for (index, value) in vlist.enumerated() {
            
            if let item = value {
                if formula(item) == true {  //add magic here..
                    results = index
                }
            }
        }
        
        return results
    }
    
    
    //MARK: Helper function
    
    
    private func hash (_ key: Key) -> Int {
       
       /*
        conforming indexable objects are required to have an
        ascii representation to be used by the hash algorithm.
        */
       
       var remainder: Int = 0
       remainder = key.asciiRepresentation % vlist.count
       return remainder
   }
    
    
}
