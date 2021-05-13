//
//  Glossary.swift
//  
//
//  Created by Wayne Bishop on 4/27/21.
//

import Foundation
    
/// (Re)Create the base functionality for a native Dictionary object.

  class Glossary <Key, Value> where Key : Indexable {
    
   //class Glossary <Key: Indexable, Value> { //alternate signature..
    
   private var klist = Set<Key>()
   private var vlist = Array<Value?>(repeating: nil, count: 100)

    
    //return keys
    var keys: Array<Key> {
        return Array<Key>(klist)
    }
    
    
    //return values
    var values: Array<Value?> {
        
        //check keys for corresponding values
        let results = klist.map { (key: Key) -> Value? in
            
            let value = self.valueForKey(key)
            return value
        }
            
        return results
    }
    

    
    //insert or update - O(1)
    @discardableResult public func updateValue(_ value: Value, forKey key: Key) -> Value? {
        
        var results: Value?
        
        if klist.contains(key) {
            if let oldValue = self.valueForKey(key) {
                results = oldValue
            }
        }
                
        //insert, update existing key
        klist.insert(key)
        
        //generate unique hash
        let index = self.hash(key)
        
        //modify bucket list
        vlist[index] = value
        
       
        return results
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
    public func removeValue(forkey key: Key) {
            
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

        
    
}
