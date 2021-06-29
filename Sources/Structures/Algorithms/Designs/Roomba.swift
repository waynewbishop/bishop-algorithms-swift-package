//
//  Roomba.swift
//  
//
//  Created by Wayne Bishop on 12/22/20.
//

import Foundation


class Roomba <T: Equatable> {
    
    var room = Graph<T>()
    var history = Priority<T>()
    
    
    private var last = Vertex<T>()
    
    private var revisited: Float = 0
    private var total: Float = 0
    
    
    //last known location
    public var lastLocation: Vertex <T>? {
        return last
    }
        
    //is the room clean?
    public var threshold: Float {
        return revisited / total
    }
        
    public init(_ location: T) {
                
        let center = Vertex<T>(with: location)
        room.addVertex(element: center)
        
        total += 1
        history.add(location)
        
        //set location
        self.last = center
    }
    
    
    public func trackDeviceTurn(_ destination: T) {  //delegate callback from rooma API..
        
        //check room for previous visit..
        for v in self.room.canvas {
            
            //todo: change to work by reference..
            
            if let vcleaned = v.tvalue as? Vector {
                
                if let location = destination as? Vector {
                    if location == vcleaned {
                        
                        print("existing turn..")
                        
                        revisited += 1
                        history.add(destination)
                        
                        //make new connection
                        room.addEdge(source: last, neighbor: v, weight: 0)
                        last = v
                        
                        return
                    }
                }
            }
        }
        
        
        print("new turn..")
        
        //build and extend graph
        let newLocation = Vertex<T>(with: destination)
        
        total += 1
        history.add(destination)
        
        room.addVertex(element: newLocation)
        room.addEdge(source: last, neighbor: newLocation, weight: 0)
        
        //revise new location
        last = newLocation
        
    }
    
    
    /*
     note: since the room is modeled using a graph, we can
     track the area of coverage the device has taken using a
     standard BFS algorithm. The first item added the canvas
     will always be the initial starting point.
     */
    func trackDeviceCoverage() {
        
        if let firstVector = self.room.canvas.first {
            self.room.traverse(firstVector)
        }
    }
    
    
} //end class

