//
//  Roomba.swift
//  
//
//  Created by Wayne Bishop on 12/22/20.
//

import Foundation


class Roomba <T> {
    
    var room = Graph<T>()
    private var current = Vertex<T>()
    
    //last known location
    public var lastLocation: Vertex <T>? {
        return current
    }

    
    public init(_ location: T) {
        
        let center = Vertex<T>(with: location)
        room.addVertex(element: center)
        
        //set location
        self.current = center
    }
    
    
    public func newTurn(_ destination: T) {
        
        //check room to determine if location has been visited..
        for v in self.room.canvas {
            
            if let vcleaned = v.tvalue as? Vector {
                
                if let location = destination as? Vector {
                    if location == vcleaned {
                        
                        v.count += 1
                        room.addEdge(source: current, neighbor: v, weight: 0)
                        current = v
                        
                        return
                    }
                }
            }
        }
        
        
        //build and extend graph
        let newLocation = Vertex<T>(with: destination)
        
        room.addVertex(element: newLocation)
        room.addEdge(source: current, neighbor: newLocation, weight: 0)
        
        //revise new location
        current = newLocation
        
    }
    
}
