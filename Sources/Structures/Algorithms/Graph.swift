//
//  Graph.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A graph data structure representing relationships between vertices via edges
///
/// This class implements a comprehensive graph with support for multiple algorithms:
/// - **Shortest paths**: Dijkstra's algorithm (array-based and heap-optimized versions)
/// - **Web ranking**: PageRank algorithm with damping factor
/// - **Dependency ordering**: Topological sort for directed acyclic graphs
/// - **Graph traversal**: Breadth-first search (BFS) with closure support
/// - **Social networks**: Mutual neighbor discovery (e.g., friend recommendations)
///
/// **Graph Representation:**
/// Uses an adjacency list representation where each vertex maintains an array of outgoing
/// edges. This representation is space-efficient for sparse graphs (few edges relative to
/// possible connections).
///
/// **Directed vs. Undirected:**
/// - **Directed graph**: Add edge from A to B creates A→B only
/// - **Undirected graph**: Add edges from A to B AND from B to A creates A↔B
///
/// **Use Cases:**
/// - Road networks and GPS routing (Dijkstra's shortest path)
/// - Web page ranking and search engines (PageRank)
/// - Build systems and task scheduling (topological sort)
/// - Social network analysis (mutual friends, BFS traversal)
///
/// - Note: The `canvas` property stores all vertices in the graph. The term "canvas"
///         reflects the visual metaphor of vertices arranged on a canvas with edges
///         drawn between them.
public class Graph <T> {

    /// Array storing all vertices in the graph
    ///
    /// The "canvas" contains every vertex in the graph. Edges are stored within each
    /// vertex's `neighbors` array rather than in a separate structure. This adjacency
    /// list representation provides O(1) vertex addition and efficient edge iteration.
    var canvas: Array<Vertex<T>>


    /// Creates a new empty graph with no vertices or edges
    ///
    /// Initializes an empty graph ready to accept vertices via `addVertex` and edges
    /// via `addEdge`. The graph can represent any relationship structure based on how
    /// vertices and edges are added.
   public init() {
        canvas = Array<Vertex>()
    }



    /// Adds a vertex to the graph
    ///
    /// Appends the vertex to the graph's canvas. The vertex can then be connected to
    /// other vertices via `addEdge`. Vertices should be added before creating edges
    /// between them.
    ///
    /// - Parameter element: The vertex to add to the graph
    ///
    /// - Complexity: O(1) amortized (array append)
    public func addVertex(element: Vertex<T>) {
        canvas.append(element)
    }


    /// Creates a directed edge from source vertex to neighbor vertex
    ///
    /// Adds a weighted edge representing a relationship or connection from the source
    /// to the neighbor. The edge is stored in the source vertex's adjacency list.
    ///
    /// **Creating Undirected Edges:**
    /// For an undirected graph, call this method twice with reversed parameters:
    /// ```swift
    /// graph.addEdge(source: A, neighbor: B, weight: 5)
    /// graph.addEdge(source: B, neighbor: A, weight: 5)
    /// ```
    ///
    /// - Parameters:
    ///   - source: The starting vertex (edge tail)
    ///   - neighbor: The destination vertex (edge head)
    ///   - weight: The cost, distance, or strength of the connection
    ///
    /// - Complexity: O(1) to create and append the edge
    public func addEdge(source: Vertex<T>, neighbor: Vertex<T>, weight: Int) {

        //create a new edge
        let newEdge = Edge<T>()

        //connect source vertex with the neighboring edge
        newEdge.neighbor = neighbor
        newEdge.weight = weight

        source.neighbors.append(newEdge)

    }

    


    //MARK: Dijkstra's Shortest Path

    /// Computes shortest path using Dijkstra's algorithm with array-based frontier
    ///
    /// This method implements the classic Dijkstra's shortest path algorithm using an
    /// array to store the frontier (unexplored paths). The algorithm:
    /// 1. Initializes frontier with paths to source's immediate neighbors
    /// 2. Repeatedly selects the shortest path from the frontier (greedy approach)
    /// 3. Explores that path's destination neighbors, creating new paths
    /// 4. Adds new paths to frontier and preserves selected path in finalPaths
    /// 5. Continues until frontier is empty
    /// 6. Returns the shortest path to destination from finalPaths
    ///
    /// **Algorithm Complexity:**
    /// - **Overall**: O(V²) due to linear search for minimum path in frontier
    /// - **Finding minimum**: O(n) linear scan through frontier array (lines 91-102)
    /// - **Path extensions**: O(E) total across all iterations
    ///
    /// For improved performance, use `processDijkstraWithHeap` which achieves O((V+E) log V)
    /// by using a min-heap to find the minimum path in O(1) instead of O(n).
    ///
    /// - Parameters:
    ///   - source: The starting vertex
    ///   - destination: The target vertex to reach
    ///
    /// - Returns: The shortest path from source to destination, or `nil` if no path exists
    ///
    /// - Complexity: O(V²) for dense graphs. Use heap version for better performance on
    ///              large graphs.
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




    /// Computes shortest path using heap-optimized Dijkstra's algorithm
    ///
    /// This method implements an optimized version of Dijkstra's algorithm using a min-heap
    /// (`PathHeap`) to manage the frontier. The key optimization: extracting the shortest
    /// path from the heap is O(1) via `peek()`, versus O(n) linear search in the array version.
    ///
    /// **Algorithm Overview:**
    /// 1. Initializes frontier heap with paths to source's immediate neighbors
    /// 2. Repeatedly extracts minimum path from heap in O(1) - the greedy choice
    /// 3. Explores that path's destination neighbors, creating new paths
    /// 4. Adds new paths to frontier heap (O(log n) each)
    /// 5. If best path reaches destination, adds to finalPaths heap
    /// 6. Returns shortest path from finalPaths
    ///
    /// **Performance Comparison:**
    /// - **Array version**: O(V²) - O(n) to find minimum path in frontier
    /// - **Heap version**: O((V+E) log V) - O(1) to peek minimum, O(log n) to add/remove
    ///
    /// For dense graphs with many vertices, the heap version provides significant speedup.
    ///
    /// - Parameters:
    ///   - source: The starting vertex
    ///   - destination: The target vertex to reach
    ///
    /// - Returns: The shortest path from source to destination, or `nil` if no path exists
    ///
    /// - Complexity: O((V+E) log V) where V is vertices and E is edges. Much faster than
    ///              O(V²) array version for large graphs.
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




    /// Reverses a path chain to reconstruct the route from source to destination
    ///
    /// Dijkstra's algorithm builds paths in reverse order (destination back to source) via
    /// the `previous` pointer. This method reverses that chain to produce a forward path
    /// from source to destination.
    ///
    /// **Algorithm:**
    /// Uses the standard linked list reversal technique:
    /// 1. Traverses the path chain following `previous` pointers
    /// 2. Reverses each `previous` link to point in the opposite direction
    /// 3. Appends a new path segment for the source vertex at the beginning
    ///
    /// This is analogous to reversing a linked list - same three-pointer technique
    /// (current, prev, next) to reverse direction while traversing.
    ///
    /// - Parameters:
    ///   - head: The final path (destination end of the chain)
    ///   - source: The source vertex to prepend to the reversed path
    ///
    /// - Returns: A path chain starting at source and ending at the original head's destination
    ///
    /// - Complexity: O(n) where n is the number of path segments (vertices in the route)
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




    //MARK: PageRank Algorithms

    /// Computes PageRank scores using simplified algorithm with sink handling
    ///
    /// This method implements a basic PageRank algorithm that distributes authority scores
    /// across the graph over multiple iterations. It demonstrates the core concept: pages
    /// linked to by important pages become important themselves.
    ///
    /// **Algorithm:**
    /// 1. **Round 0**: Equal allocation - all vertices get `100/vertex_count` rank (random surfer)
    /// 2. **Round 1**: Authority distribution:
    ///    - **Standard vertices**: Divide current rank equally among outgoing neighbors
    ///    - **Sink vertices** (no outgoing edges): Distribute rank to all other vertices
    /// 3. **Iterations**: Currently runs 2 rounds (line 289)
    ///
    /// **Sink Handling:**
    /// Vertices with no outgoing edges (sink nodes) would lose their rank permanently.
    /// This implementation redistributes sink rank to all other vertices, preventing rank
    /// from disappearing from the graph.
    ///
    /// **Limitations:**
    /// - Fixed 2 iterations (production would run until convergence)
    /// - No damping factor (see `processPageRankWithDamping` for proper damping)
    /// - Uses educational scale (0-100) instead of mathematical scale (0.0-1.0)
    ///
    /// - Complexity: O(R × (V + E)) where R is rounds (2), V is vertices, E is edges
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


    /// Computes PageRank scores using production-grade algorithm with damping and convergence
    ///
    /// This method implements the complete PageRank algorithm as used by search engines,
    /// including the damping factor that models user behavior: users follow links with
    /// probability `dampingFactor` (0.85), or jump to a random page with probability
    /// `1 - dampingFactor` (0.15).
    ///
    /// **Algorithm Enhancements:**
    /// - **Damping factor**: Prevents rank from accumulating in sink nodes
    /// - **Convergence detection**: Stops when changes fall below threshold (not fixed iterations)
    /// - **Mathematical scale**: Uses 0.0-1.0 scale (sum of all ranks = 1.0)
    /// - **Random jump baseline**: All vertices start each iteration with `(1-d)/V` rank
    ///
    /// **Formula:**
    /// ```
    /// PageRank(v) = (1-d)/V + d × Σ(PageRank(u) / OutDegree(u))
    /// ```
    /// Where sum is over all vertices u linking to v.
    ///
    /// **Convergence:**
    /// Iterates until the maximum rank change across all vertices is below `convergenceThreshold`,
    /// or until `maxIterations` is reached.
    ///
    /// - Parameters:
    ///   - dampingFactor: Probability of following links vs random jump (default: 0.85)
    ///   - maxIterations: Maximum iterations before stopping (default: 100)
    ///   - convergenceThreshold: Minimum change required to continue (default: 0.0001)
    ///
    /// - Complexity: O(I × (V + E)) where I is iterations until convergence
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

    /// Performs topological sort on a directed acyclic graph using DFS-based approach
    ///
    /// Topological sort produces a linear ordering of vertices such that for every directed
    /// edge u→v, vertex u appears before v in the ordering. This is essential for:
    /// - **Build systems**: Compile dependencies before dependents
    /// - **Task scheduling**: Complete prerequisites before dependent tasks
    /// - **Course planning**: Take prerequisite courses before advanced courses
    ///
    /// **Algorithm:**
    /// Uses depth-first search with post-order stack addition:
    /// 1. Performs DFS from each unvisited vertex
    /// 2. Recursively visits all neighbors before processing current vertex
    /// 3. Adds vertex to stack AFTER all descendants are visited (post-order)
    /// 4. Reverses stack to get topological order
    ///
    /// **Cycle Detection:**
    /// Uses white-gray-black coloring:
    /// - **White** (unvisited): Not yet discovered
    /// - **Gray** (visiting): Currently in DFS recursion stack
    /// - **Black** (visited): Fully processed
    ///
    /// If we encounter a gray vertex during traversal, a back edge exists (cycle detected).
    /// Topological sort only works on DAGs (directed acyclic graphs).
    ///
    /// - Returns: Array of vertices in topological order, or `nil` if a cycle is detected
    ///
    /// - Complexity: O(V + E) time (visits each vertex and edge once), O(V) space for
    ///              recursion depth and tracking arrays
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


    /// Recursive DFS helper for topological sort with cycle detection
    ///
    /// This method implements the depth-first search portion of topological sort using
    /// the white-gray-black coloring algorithm for cycle detection:
    ///
    /// **Color States:**
    /// - **White** (not in visiting or visited): Unvisited vertex
    /// - **Gray** (in visiting array): Currently in DFS recursion stack
    /// - **Black** (in visited array): Fully processed, all descendants visited
    ///
    /// **Cycle Detection:**
    /// If we encounter a vertex that's gray (currently being visited), we've found a
    /// back edge indicating a cycle. This makes topological sorting impossible.
    ///
    /// **Post-order Processing:**
    /// Vertices are added to the stack AFTER visiting all neighbors (post-order), ensuring
    /// dependencies are processed before dependents.
    ///
    /// - Parameters:
    ///   - vertex: Current vertex being visited
    ///   - stack: Accumulates vertices in reverse topological order
    ///   - visiting: Gray nodes (currently in recursion stack)
    ///   - visited: Black nodes (fully processed)
    ///
    /// - Returns: `true` if DFS succeeds without finding cycles, `false` if cycle detected
    ///
    /// - Complexity: O(V + E) across all calls (each vertex and edge visited once)
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



    //MARK: Traversal Algorithms


    /// Performs breadth-first search with custom vertex processing via inout closure
    ///
    /// This method traverses the graph level-by-level from the starting vertex, executing
    /// a user-provided closure on each vertex. The closure receives an `inout` parameter,
    /// allowing it to modify vertex properties during traversal.
    ///
    /// **BFS Characteristics:**
    /// - **Level-order**: Visits all vertices at distance k before visiting any at distance k+1
    /// - **Shortest paths**: For unweighted graphs, BFS finds shortest paths
    /// - **Uses queue**: FIFO ensures level-by-level exploration
    ///
    /// **Inout Closure Pattern:**
    /// The formula closure receives a mutable reference to each vertex, enabling property
    /// updates without explicit return values:
    /// ```swift
    /// graph.traverse(startVertex) { vertex in
    ///     vertex.visited = true
    ///     vertex.rank[0] = calculateRank(vertex)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - startingv: The vertex to begin traversal from
    ///   - formula: Closure executed on each visited vertex (receives inout reference)
    ///
    /// - Complexity: O(V + E) where V is vertices and E is edges
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




    /// Discovers vertices connected to the source's neighbors but not to the source itself
    ///
    /// This method implements "mutual friends" or "people you may know" recommendation logic.
    /// It finds vertices that share connections with the source but aren't directly connected
    /// to the source, ranking them by frequency of shared connections.
    ///
    /// **Algorithm:**
    /// 1. Iterate through source's direct neighbors (friends)
    /// 2. For each neighbor, examine all vertices in the graph
    /// 3. If a vertex links to the same neighbor but isn't the source, it's a mutual connection
    /// 4. Add to priority queue (frequency-based ranking via `Priority<T>`)
    ///
    /// **Social Network Example:**
    /// If Alice (source) is friends with Bob, and Carol is also friends with Bob but not Alice,
    /// Carol appears as a mutual neighbor recommendation. If Carol is friends with multiple of
    /// Alice's friends, she ranks higher in the priority queue.
    ///
    /// - Parameter source: The source vertex to find recommendations for
    ///
    /// - Returns: Priority queue of mutual neighbors, ranked by number of shared connections
    ///
    /// - Complexity: O(V × E) where V is vertices and E is edges - examines entire graph
    ///              for each of source's neighbors
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
    



    /// Performs breadth-first search with console output for educational purposes
    ///
    /// This method implements standard BFS traversal, printing each vertex as it's visited.
    /// Unlike the closure-based version, this method simply marks vertices as visited and
    /// logs the traversal order to the console.
    ///
    /// **Educational Use:**
    /// Demonstrates the core BFS algorithm without the complexity of closure parameters.
    /// Useful for visualizing graph connectivity and understanding BFS traversal order.
    ///
    /// - Parameter startingv: The vertex to begin traversal from
    ///
    /// - Complexity: O(V + E) where V is vertices and E is edges
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
    



    /// Performs breadth-first search with boolean validation closure
    ///
    /// This method traverses the graph using BFS while executing a validation closure on
    /// each vertex. The closure returns `Bool` indicating success/failure of the update
    /// operation, allowing error handling during traversal.
    ///
    /// **Use Case:**
    /// Useful when vertex updates might fail and you need to log or handle failures
    /// separately. For example, validating data constraints, checking permissions, or
    /// conditional vertex modifications.
    ///
    /// **Formula Closure:**
    /// The formula receives each vertex and returns `true` for successful update or `false`
    /// for failure. Failed updates are logged to console but don't stop traversal.
    ///
    /// - Parameters:
    ///   - startingv: The vertex to begin traversal from
    ///   - formula: Closure that processes each vertex and returns success/failure
    ///
    /// - Complexity: O(V + E) where V is vertices and E is edges
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
