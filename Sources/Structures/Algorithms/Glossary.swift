//
//  Glossary.swift
//  
//
//  Created by Wayne Bishop on 4/27/21.
//

import Foundation


/// (Re)Create the base functionality for a native Dictionary object.

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

    
    //insert or update - O(1)
    public func updateValue(_ value: Value, for key: Key) {
        
        //insert, update existing key
        klist.insert(key)
        
        //generate unique hash
        let index = self.hash(key)
        
        //add to bucket list
        vlist[index] = value
    }
    
    
    //retreive value - O(1)
    public func valueForKey(_ key: Key) -> Value? {
        
        var results: Value?
                
        //generate unique hash
        let index = self.hash(key)
        
        if vlist.indices.contains(index) {
            results = vlist[index]
        }
            
        return results
    }
    
    
    //remove key-value pair - O(1)
    public func removeValue(for key: Key) {
            
        //generate unique hash
        let index = self.hash(key)
        
        if vlist.indices.contains(index) {
            
            //reset value at index
            vlist[index] = nil

            //remove related key
            klist.remove(key)
        }
    }
    
    
    private func hash (_ key: Key) -> Int {
       
       /*
        conforming indexable objects are required to have an
        ascii representation to be used by the hash algorithm.
        */
       
       var remainder: Int = 0
       remainder = key.asciiRepresentation % vlist.count
       return remainder
   }

    
    

    //MARK: Closure operations
    
    
    //returns the first index - O(n)
    public func firstIndex(of formula: (Value) -> Bool) -> Int? {
        
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
    
        
    
}
