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
    
    
    
    ///add vertex to graph canvas
    /// - Parameter element: the vertex to be added to the graph
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
        var shortestPath: Path<T>? = nil


        for itemPath in finalPaths {

            if (itemPath.destination == destination) {

                if (shortestPath == nil) || (itemPath.total < shortestPath!.total) {
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


        var current: Path<T>? = output
        var prev: Path<T>? = nil
        var next: Path<T>? = nil


        while current != nil {
            next = current?.previous
            current?.previous = prev
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


    /// Enhanced PageRank with damping factor and convergence detection
    /// - Parameters:
    ///   - dampingFactor: Probability of following links vs random jump (default: 0.85)
    ///   - maxIterations: Maximum iterations before stopping (default: 100)
    ///   - convergenceThreshold: Minimum change required to continue (default: 0.0001)
    public func processPageRankWithDamping(dampingFactor: Float = 0.85,
                                         maxIterations: Int = 100,
                                         convergenceThreshold: Float = 0.0001) {

        // Use mathematical PageRank scale (0.0 to 1.0)
        let startingRank: Float = 1.0 / Float(self.canvas.count)
        let randomJumpProbability = (1.0 - dampingFactor) / Float(self.canvas.count)

        var iteration: Int = 0
        var hasConverged = false

        // Initialize all vertices with equal starting rank
        for vertex in self.canvas {
            vertex.rank = [startingRank, 0, 0]  // Only use first two slots
        }

        while iteration < maxIterations && !hasConverged {

            // Reset next iteration ranks to random jump baseline
            for vertex in self.canvas {
                vertex.rank[1] = randomJumpProbability
            }

            // Calculate authority distribution for this iteration
            for vertex in self.canvas {
                let currentRank = vertex.rank[0]

                // Standard case: Distribute rank to neighbors
                if vertex.neighbors.count > 0 {
                    let linkContribution = (dampingFactor * currentRank) / Float(vertex.neighbors.count)

                    for edge in vertex.neighbors {
                        edge.neighbor.rank[1] += linkContribution
                    }
                }
                // Sink node case: Distribute to all other vertices
                else {
                    if self.canvas.count > 1 {
                        let sinkContribution = (dampingFactor * currentRank) / Float(self.canvas.count - 1)

                        for otherVertex in self.canvas {
                            if vertex != otherVertex {
                                otherVertex.rank[1] += sinkContribution
                            }
                        }
                    }
                }
            }

            // Check for convergence
            var maxChange: Float = 0
            for vertex in self.canvas {
                let change = abs(vertex.rank[1] - vertex.rank[0])
                maxChange = max(maxChange, change)

                // Move new rank to current rank for next iteration
                vertex.rank[0] = vertex.rank[1]
            }

            hasConverged = maxChange < convergenceThreshold
            iteration += 1
        }

        // Store final results in the last slot for compatibility
        for vertex in self.canvas {
            vertex.rank[2] = vertex.rank[0] * 100  // Scale back to educational format
        }

        print("PageRank converged after \(iteration) iterations")
    }



    //MARK: Topological Sort

    /// Performs topological sort on a directed acyclic graph (DAG) using DFS-based approach
    /// - Returns: Array of vertices in topological order, or nil if cycle detected
    /// - Complexity: O(V + E) time, O(V) space for recursion
    public func topologicalSort() -> [Vertex<T>]? {
        var stack: [Vertex<T>] = []
        var visiting: [Vertex<T>] = []  // For cycle detection (gray nodes)
        var visited: [Vertex<T>] = []   // Fully processed (black nodes)

        // Reset visited flags
        for vertex in canvas {
            vertex.visited = false
        }

        // Process all vertices (handles disconnected components)
        for vertex in canvas {
            if !vertex.visited {
                if !topologicalDFS(vertex, stack: &stack, visiting: &visiting, visited: &visited) {
                    return nil  // Cycle detected - not a DAG
                }
            }
        }

        return stack.reversed()  // Reverse to get correct topological order
    }


    /// Helper function for DFS-based topological sort with cycle detection
    /// Uses white-gray-black algorithm: white (unvisited), gray (visiting), black (visited)
    private func topologicalDFS(_ vertex: Vertex<T>,
                                stack: inout [Vertex<T>],
                                visiting: inout [Vertex<T>],
                                visited: inout [Vertex<T>]) -> Bool {

        // Cycle detection: if we encounter a vertex we're currently visiting (gray node)
        if visiting.contains(where: { $0 == vertex }) {
            return false  // Back edge found - cycle exists
        }

        if visited.contains(where: { $0 == vertex }) {
            return true  // Already processed (black node)
        }

        visiting.append(vertex)  // Mark as gray (currently visiting)

        // Visit all neighbors recursively
        for edge in vertex.neighbors {
            if !topologicalDFS(edge.neighbor, stack: &stack, visiting: &visiting, visited: &visited) {
                return false
            }
        }

        // Remove from gray set
        if let index = visiting.firstIndex(where: { $0 == vertex }) {
            visiting.remove(at: index)
        }

        visited.append(vertex)  // Mark as black (fully processed)
        vertex.visited = true

        // Post-order: add to stack AFTER visiting all neighbors
        // This ensures dependencies are processed before dependents
        stack.append(vertex)

        return true
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
