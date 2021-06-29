//
//  Graph.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
A `Graph` defines a relationship between two or more `Vertices`.
 */

public class Graph <T> {
   
    var canvas: Array<Vertex<T>>
    
    
   public init() {
        canvas = Array<Vertex>()
    }
    
    
    //add vertex to graph canvas
    public func addVertex(element: Vertex<T>) {
        canvas.append(element)
    }
        
    
    
    /// Represents a relationship between neighboring vertices
    /// - Parameters:
    ///   - source: Source Vertex
    ///   - neighbor: Destination Vertex
    ///   - weight: Edge Weight (level of connectedness).
    
    public func addEdge(source: Vertex<T>, neighbor: Vertex<T>, weight: Int) {
        
        //create a new edge
        let newEdge = Edge<T>()
        
        //connect source vertex with the neighboring edge
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        
        source.neighbors.append(newEdge)
        
        //todo: we need to know who following the neighbor..
        //we can pass source and destination as a reference to create a matrix??
        
    }

    

    
    //process Dijkstra's shortest path algorithm
    public func processDijkstra(_ source: Vertex<T>, destination: Vertex<T>) -> Path<T>? {
            
        var frontier: Array<Path<T>> = Array<Path<T>>()
        var finalPaths: Array<Path<T>> = Array<Path<T>>()
        
        
        //use source edges to populate the frontier
        for e in source.neighbors {
            
            let newPath: Path = Path<T>()
            
            
            newPath.destination = e.neighbor
            newPath.previous = nil
            newPath.total = e.weight
            
            
            //add the new path to the frontier
            frontier.append(newPath)
            
        }
        

        //construct the best path
        var bestPath: Path = Path<T>()
        
        
        while frontier.count != 0 {
            
            bestPath = Path()
            
            //support path changes using the greedy approach - O(n)
            var pathIndex: Int = 0
            
            
            for x in 0..<frontier.count {
               
                let itemPath: Path = frontier[x]
                
                if  (bestPath.total == 0) || (itemPath.total < bestPath.total) {
                    bestPath = itemPath
                    pathIndex = x
                }
            }
            
            
            //enumerate the bestPath edges
            for e in bestPath.destination.neighbors {
                
                let newPath: Path = Path<T>()
                
                newPath.destination = e.neighbor
                newPath.previous = bestPath
                newPath.total = bestPath.total + e.weight
                
                
                
                //add the new path to the frontier
                frontier.append(newPath)
            }
            
            
            //preserve the bestPath
            finalPaths.append(bestPath)
            
            
            //remove the bestPath from the frontier
            frontier.remove(at: pathIndex)
            
            
            
        } //end while
        
        
    
        //establish the shortest path as an optional
        var shortestPath: Path! = Path<T>()
        
        
        for itemPath in finalPaths {
            
            if (itemPath.destination == destination) {
                
                if  (shortestPath.total == 0) || (itemPath.total < shortestPath.total) {
                    shortestPath = itemPath
                }
                
            }
            
        }
        
        
        return shortestPath
        
    }
    
    
    
    ///An optimized version of Dijkstra's shortest path algorthim
    public func processDijkstraWithHeap(_ source: Vertex<T>, destination: Vertex<T>) -> Path<T>? {
        
        
        let frontier: PathHeap = PathHeap<T>()
        let finalPaths: PathHeap = PathHeap<T>()
        
        
        //use source edges to create the frontier
        for e in source.neighbors {
            
            let newPath: Path = Path<T>()
            
            
            newPath.destination = e.neighbor
            newPath.previous = nil
            newPath.total = e.weight
            
            
            //add the new path to the frontier - O(log n)
            frontier.enQueue(newPath)
            
        }
        
        
        //construct the best path
        while frontier.count != 0 {
                        
            //use the greedy approach to obtain the best path - O(1)
            guard let bestPath: Path = frontier.peek() else {
                break
            }
            
            
            //enumerate the bestPath edges
            for e in bestPath.destination.neighbors {
                
                let newPath: Path = Path<T>()
                
                newPath.destination = e.neighbor
                newPath.previous = bestPath
                newPath.total = bestPath.total + e.weight
                
                
                //add the new path to the frontier
                frontier.enQueue(newPath)
            
            }
            
            
            //preserve the bestPaths that match destination
            if (bestPath.destination == destination) {
                finalPaths.enQueue(bestPath)
            }
            
            
            //remove the bestPath from the frontier
            frontier.deQueue()
            
            
        } //end while
        
        
        
        //obtain the shortest path from the heap
        var shortestPath: Path? = Path<T>()
        shortestPath = finalPaths.peek()
        
        
        return shortestPath
        
    }
    
    
    
    /**
     Reverse the sequence of paths given the shortest path. Process analagous to reversing a linked list..
     
     - Parameter head: The source Vertex.
     - Parameter source: The connecting destination `Vertex`.
     - Returns: The reversed `Path`.
     */

    public func reversePath(_ head: Path<T>?, source: Vertex<T>) -> Path<T>? {
        
        
        guard head != nil else {
            return head
        }
        
        //mutated copy
        var output = head
        
        
        var current: Path! = output
        var prev: Path<T>!
        var next: Path<T>!
        
        
        while(current != nil) {
            next = current.previous
            current.previous = prev
            prev = current
            current = next
        }
        
        
        //append the source path to the sequence
        let sourcePath: Path = Path<T>()
        
        sourcePath.destination = source
        sourcePath.previous = prev
        sourcePath.total = 0
        
        output = sourcePath
        
        
        return output
        
    }
    
    
        
    
    //MARK: PageRank algorithms
    
    public func processPageRankWithSink() {
                
        let startingRank: Float = roundf(Float((100 / self.canvas.count))) //todo: change from default 100 to 1?
        var round: Int = 0
        
        
        while round < 2 {
            
            for v in self.canvas {
                
                //equal allocation - random surfer
                if round == 0 {
                    v.rank[round] = startingRank
                }
                
                let currRank = v.rank[round]
                
                //calculate & assign
                if v.neighbors.count > 0 {
                    
                    let assignedRank = roundf(currRank / Float(v.neighbors.count))
                    
                    
                    //assign rank
                    for m in v.neighbors {
                        m.neighbor.rank[round + 1] += assignedRank
                    }
                }
                
                //sink vertex - distribute previous rank to other vertices
                else {
                    if self.canvas.count > 1 {
                        
                        let sinkRank = currRank / (Float(self.canvas.count) - 1)
                        
                        for m in self.canvas {
                            if v != m {
                                m.rank[round + 1] += sinkRank
                            }
                        }
                    }
                }
            }

            //advance to next round
            round += 1
            
            //todo: if you are in the final round, then add the resulting
            //vertex rank values to a heap..
        }
        
        
    }

        
    
    //MARK: traversal algorithms
    
    
    //bfs traversal with inout closure function
    public func traverse(_ startingv: Vertex<T>, formula: (_ node: inout Vertex<T>) -> ()) {

        
        //establish a new queue
        let graphQueue: Queue<Vertex<T>> = Queue<Vertex<T>>()
        
        
        //queue a starting vertex
        graphQueue.enQueue(startingv)
        
        
        while !graphQueue.isEmpty() {
            
            
            //traverse the next queued vertex
            guard var vitem = graphQueue.deQueue() else {
                break
            }
            
            //add unvisited vertices to the queue
            for e in vitem.neighbors {
                if e.neighbor.visited == false {
                    print("adding vertex: \(e.neighbor.tvalue!) to queue..")
                    graphQueue.enQueue(e.neighbor)
                }
            }
            

            /*
            notes: this demonstrates how to invoke a closure with an inout parameter.
            By passing by reference no return value is required.
            */
            
            //invoke formula
            formula(&vitem)

            
        } //end while
        
        
        print("graph traversal complete..")
        
        
    }


    
    
    /// Identifies all unconnected vertices of related neighbors (e.g. mutual friends).
    ///
    /// - Parameter source: the source vertex
    /// - Returns: the list of unconnected vertices, based on priority
    
    public func mutualNeighbors(of source: Vertex<T>) -> Priority<Vertex<T>>  {
       
        let priority = Priority<Vertex<T>>()
                
        //initialize source list
        for e in source.neighbors {
            
            //iterate through entire graph
            for g in self.canvas {
                
                //examine each neighbors adjacency list
                for s in g.neighbors {
                    if (s.neighbor == e.neighbor) && (s.neighbor != source) {
                        print("mutual connection found..")
                        priority.add(g)
                    }
                }
            }
        }
    
                
        return priority
    }
    
    
    
    //breadth first search
    public func traverse(_ startingv: Vertex<T>) {
        
        
        //establish a new queue
        let graphQueue: Queue<Vertex> = Queue<Vertex<T>>()
        
        
        //queue a starting vertex
        graphQueue.enQueue(startingv)
        
        
        while !graphQueue.isEmpty() {
            
            
            //traverse the next queued vertex
            guard let vitem = graphQueue.deQueue() else {
                break
            }

            
            //add unvisited vertices to the queue
            for e in vitem.neighbors {
                if e.neighbor.visited == false {
                   // print("adding vertex: \(e.neighbor.tvalue) to queue..")
                    graphQueue.enQueue(e.neighbor)
                }
            }
            
        
            vitem.visited = true
            print("traversed vertex: \(vitem.tvalue!)..")
            
            
        } //end while
        
        
        print("graph traversal complete..")
        
        
    } //end function
    
    
    
    //use bfs with trailing closure to update all values
    func update(startingv: Vertex<T>, formula:((Vertex<T>) -> Bool)) {
        
        
        //establish a new queue
        let graphQueue: Queue<Vertex<T>> = Queue<Vertex<T>>()
        
        
        //queue a starting vertex
        graphQueue.enQueue(startingv)
        
        
        while !graphQueue.isEmpty() {
            
            //traverse the next queued vertex - Swift 4.0
            //let vitem = graphQueue.deQueue() as Vertex!

            //traverse the next queued vertex
            guard let vitem = graphQueue.deQueue() else {
                break
            }

            
            //add unvisited vertices to the queue
            for e in vitem.neighbors {
                if e.neighbor.visited == false {
                    print("adding vertex: \(e.neighbor.tvalue!) to queue..")
                    graphQueue.enQueue(e.neighbor)
                }
            }
            
            
            //apply formula..
            if formula(vitem) == false {
                print("formula unable to update: \(String(describing: vitem.tvalue))")
            }
            else {
                print("traversed vertex: \(vitem.tvalue!)..")
            }
            
            vitem.visited = true
            
            
        } //end while
        
        
        print("graph traversal complete..")
                
    }
    
    
}
