//
//  Knowledge.swift
//  
//
//  Created by Wayne Bishop on 6/16/21.
//

import Foundation


public class Knowledge <T: Hashable> {
    
    //todo: change canvas to a priority queue to support modeling
    var canvas = Set<Entity<T>>()

    
    public init() {
        //code goes here..
    }
    
    //add entity to graph canvas
    public func addEntity(_ element: inout Entity<T>) {
        canvas.insert(element)
    }
    
    
    public func newFact(for source: inout Entity<T>, neighbor: inout Entity<T>, token: Token) {
        
        //create a new fact
        let fact = Fact<T>()
                
        //connect source entity with the neighboring fact
        fact.neighbor = neighbor
        fact.token = token
        
        source.neighbors.append(fact)
        
        //add the source as a connection
        neighbor.connections.insert(source)
    }
    
    
    public func mutualFriends(of source: inout Entity<T>) -> [Table<Entity<T>>] {
                
        let priority = Priority<Entity<T>>()
        var results = [Table<Entity<T>>]()
        
        //check adjacency list
        for s in source.neighbors {

            //check their connections
            for c in s.neighbor.connections {
                
                if c != source {

                    var isConnected = false
                    
                    //already connected to source?
                    for f in c.neighbors {
                        if f.neighbor == source {
                            isConnected = true
                            break
                        }
                    }
                    
                    if isConnected == false {
                        priority.add(c)
                    }
                }
            }
        }
 
        //obtain vertices with most mutual connections
        if let items = priority.get() {
            
            var most: Int = 0

            //values are pre-sorted based on priority
            for i in items {
                
                most = max(i.count, most)
                
                if (i.count == most) {
                    results.append(i)
                    continue
                    
                } else {
                    break
                }
            }            
        }
                
        return results
    }


    
    public func search(term phrase: T) -> () {
        
        //todo: parse keywords in model to determine best
        //matching fact and connection relation..
        //natural language processing??
        
        //need to create tokenization of input string to something tht
        //can be used..
        
        //todo: pass in order history as well as menu list of items..
        
        //1. parse the string into a structured data format.
        
        //2. match the first identified noun in the phrase

        /*
        self.canvas.contains { (entity: Entity) -> Bool in
            return entity.tvalue == phrase
        }
        */
        
    }

    
}
    
