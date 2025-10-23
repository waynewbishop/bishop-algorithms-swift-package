//
//  GraphTest.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 9/19/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import XCTest

@testable import Structures


/* 
   unit test cases specific to graph algorithms
   to test your own graph, replace the vertices and edges.
*/

class GraphTest: XCTestCase {
    

    var testGraph: Graph = Graph<String>()
    
    var vertexA = Vertex(with: "A")
    var vertexB = Vertex(with: "B")
    var vertexC = Vertex(with: "C")
    var vertexD = Vertex(with: "D")
    var vertexE = Vertex(with: "E")
    
    
    //called before each test invocation
    override func setUp() {
        super.setUp()
        
        /* add the vertices */
        
        testGraph.addVertex(element: vertexA)
        testGraph.addVertex(element: vertexB)
        testGraph.addVertex(element: vertexC)
        testGraph.addVertex(element: vertexD)
        testGraph.addVertex(element: vertexE)
        
        
        /* connect the vertices with weighted edges */
        
        testGraph.addEdge(source: vertexA, neighbor: vertexD, weight: 4)
        testGraph.addEdge(source: vertexA, neighbor: vertexB, weight: 1)
        testGraph.addEdge(source: vertexB, neighbor: vertexD, weight: 5)
        testGraph.addEdge(source: vertexB, neighbor: vertexC, weight: 2)
        testGraph.addEdge(source: vertexD, neighbor: vertexE, weight: 8)

    }
    
    
    //validate neighbor association
    func testVertexNeighbors() {
        
        neighborTest(of: vertexA, with: vertexD)
        neighborTest(of: vertexA, with: vertexB)
        neighborTest(of: vertexB, with: vertexD)
        neighborTest(of: vertexB, with: vertexC)
        neighborTest(of: vertexD, with: vertexE)
    }
    
    
    
    //find the shortest path using heapsort operations - O(1)
    func testDijkstraWithHeaps() {
        
        let sourceVertex = vertexA
        let destinationVertex = vertexE
        
        
        let shortestPath: Path! = testGraph.processDijkstraWithHeap(sourceVertex, destination: destinationVertex)
        XCTAssertNotNil(shortestPath, "shortest path not found..")
        
        printPath(shortestPath)
    }
    
    
    
    
    //find the shortest path based on two non-negative edge weights - O(n)
    func testDijkstra() {
        
        let sourceVertex = vertexA
        let destinationVertex = vertexE

        
        let shortestPath: Path! = testGraph.processDijkstra(sourceVertex, destination: destinationVertex)
        XCTAssertNotNil(shortestPath, "shortest path not found..")
        
        printPath(shortestPath)
    }

    
    //MARK: PageRank algorithms

        
    //pagerank with sinks - sink values are allocated to other vertices
    func testPageRankWithSink() {
        
        var probability: Float = 0.0
        
        testGraph.processPageRankWithSink()
        
        for v in testGraph.canvas {
            
            if let rvalue = v.rank.last {
                probability += rvalue
                print("\(v.tvalue!) pagerank is: \(rvalue)" )
            }
        }
             
        XCTAssert(probability == 100, "test failed: pagerank probability for all vertices does not equal 1")
    }
    
    //pagerank with damping factor - more mathematically accurate
    func testPageRankWithDamping() {

        var probability: Float = 0.0

        testGraph.processPageRankWithDamping()

        for v in testGraph.canvas {

            if let rvalue = v.rank.last {
                probability += rvalue
                print("\(v.tvalue!) pagerank with damping is: \(rvalue)" )
            }
        }

        // Should still sum to 100 (educational scale)
        XCTAssert(abs(probability - 100) < 0.01, "test failed: pagerank probability for all vertices does not equal 100")
    }



    //MARK: Topological Sort


    //test valid DAG - course prerequisites example
    func testTopologicalSortValidDAG() {

        let courseGraph = Graph<String>()

        let algebra = Vertex(with: "Algebra 101")
        let trig = Vertex(with: "Trigonometry 101")
        let math = Vertex(with: "Math 500")
        let physics = Vertex(with: "Physics")

        courseGraph.addVertex(element: algebra)
        courseGraph.addVertex(element: trig)
        courseGraph.addVertex(element: math)
        courseGraph.addVertex(element: physics)

        // Define prerequisites (edges point from prerequisite to course)
        courseGraph.addEdge(source: algebra, neighbor: trig, weight: 1)
        courseGraph.addEdge(source: algebra, neighbor: math, weight: 1)
        courseGraph.addEdge(source: trig, neighbor: math, weight: 1)
        courseGraph.addEdge(source: math, neighbor: physics, weight: 1)

        // Execute topological sort
        guard let ordering = courseGraph.topologicalSort() else {
            XCTFail("topological sort failed on valid DAG")
            return
        }

        // Verify we got all vertices
        XCTAssertEqual(ordering.count, 4, "topological sort should return all 4 vertices")

        // Print the ordering for verification
        print("\nValid course sequence:")
        for (index, vertex) in ordering.enumerated() {
            print("\(index + 1). \(vertex.tvalue!)")
        }

        // Verify dependency order: Algebra must come before Trig and Math
        let algebraIndex = ordering.firstIndex(of: algebra)!
        let trigIndex = ordering.firstIndex(of: trig)!
        let mathIndex = ordering.firstIndex(of: math)!
        let physicsIndex = ordering.firstIndex(of: physics)!

        XCTAssert(algebraIndex < trigIndex, "Algebra 101 must come before Trig 101")
        XCTAssert(algebraIndex < mathIndex, "Algebra 101 must come before Math 500")
        XCTAssert(trigIndex < mathIndex, "Trig 101 must come before Math 500")
        XCTAssert(mathIndex < physicsIndex, "Math 500 must come before Physics")

        print("✅ All dependency constraints satisfied")
    }


    //test cycle detection - should return nil
    func testTopologicalSortWithCycle() {

        let cyclicGraph = Graph<String>()

        let courseA = Vertex(with: "Course A")
        let courseB = Vertex(with: "Course B")
        let courseC = Vertex(with: "Course C")

        cyclicGraph.addVertex(element: courseA)
        cyclicGraph.addVertex(element: courseB)
        cyclicGraph.addVertex(element: courseC)

        // Create circular dependency: A → B → C → A
        cyclicGraph.addEdge(source: courseA, neighbor: courseB, weight: 1)
        cyclicGraph.addEdge(source: courseB, neighbor: courseC, weight: 1)
        cyclicGraph.addEdge(source: courseC, neighbor: courseA, weight: 1)

        // Execute topological sort - should return nil
        let ordering = cyclicGraph.topologicalSort()

        XCTAssertNil(ordering, "topological sort should return nil when cycle is detected")
        print("✅ Cycle correctly detected - topological sort returned nil")
    }


    //test edge cases - single vertex and empty graph
    func testTopologicalSortEdgeCases() {

        // Test 1: Single vertex with no edges
        let singleGraph = Graph<String>()
        let singleVertex = Vertex(with: "Only")
        singleGraph.addVertex(element: singleVertex)

        guard let singleOrdering = singleGraph.topologicalSort() else {
            XCTFail("topological sort should handle single vertex")
            return
        }

        XCTAssertEqual(singleOrdering.count, 1, "single vertex graph should return array with 1 element")
        XCTAssertEqual(singleOrdering.first, singleVertex, "returned vertex should match input")
        print("✅ Single vertex case handled correctly")


        // Test 2: Empty graph
        let emptyGraph = Graph<String>()

        guard let emptyOrdering = emptyGraph.topologicalSort() else {
            XCTFail("topological sort should handle empty graph")
            return
        }

        XCTAssertEqual(emptyOrdering.count, 0, "empty graph should return empty array")
        print("✅ Empty graph case handled correctly")


        // Test 3: Disconnected components (two separate chains)
        let disconnectedGraph = Graph<String>()

        let chain1A = Vertex(with: "Chain1-A")
        let chain1B = Vertex(with: "Chain1-B")
        let chain2A = Vertex(with: "Chain2-A")
        let chain2B = Vertex(with: "Chain2-B")

        disconnectedGraph.addVertex(element: chain1A)
        disconnectedGraph.addVertex(element: chain1B)
        disconnectedGraph.addVertex(element: chain2A)
        disconnectedGraph.addVertex(element: chain2B)

        disconnectedGraph.addEdge(source: chain1A, neighbor: chain1B, weight: 1)
        disconnectedGraph.addEdge(source: chain2A, neighbor: chain2B, weight: 1)

        guard let disconnectedOrdering = disconnectedGraph.topologicalSort() else {
            XCTFail("topological sort should handle disconnected components")
            return
        }

        XCTAssertEqual(disconnectedOrdering.count, 4, "should return all vertices from disconnected components")

        // Verify dependencies within each chain
        let chain1AIndex = disconnectedOrdering.firstIndex(of: chain1A)!
        let chain1BIndex = disconnectedOrdering.firstIndex(of: chain1B)!
        let chain2AIndex = disconnectedOrdering.firstIndex(of: chain2A)!
        let chain2BIndex = disconnectedOrdering.firstIndex(of: chain2B)!

        XCTAssert(chain1AIndex < chain1BIndex, "Chain1-A must come before Chain1-B")
        XCTAssert(chain2AIndex < chain2BIndex, "Chain2-A must come before Chain2-B")
        print("✅ Disconnected components handled correctly")
    }



    //MARK: Closures and traversals
     
    //breadth-first search
    func testBFSTraverse() {
        testGraph.traverse(vertexA)
    }
    
    
    //breadth-first search with function
    func testBFSTraverseFunction() {
        testGraph.traverse(vertexA, formula: traverseFormula)
    }
    

    
    
    //breadth-first search with closure expression
    func testBFSTraverseExpression() {
        
        /*
        notes: the inout parameter is passed by reference.
        As a result, no return type is required. Also note the trailing closure syntax.
        */
        testGraph.traverse(vertexA) { ( node: inout Vertex) -> () in
            node.visited = true
            print("traversed vertex: \(node.tvalue!)..")
        }
    }
    
    
    //closure function passed as paramete
    func traverseFormula(node: inout Vertex<String>) -> () {
        
        /*
        notes: the inout parameter is passed by reference. 
        As a result, no return type is required.
        */
        
        node.visited = true
        print("traversed vertex: \(node.tvalue!)..")
    }

    
    
    
    //MARK: - Helper function
    
    
    //check for membership
    func neighborTest(of source: Vertex<String>, with neighbor: Vertex<String>) {

        
        //add unvisited vertices to the queue
        for e in source.neighbors {
            if (e.neighbor.tvalue == neighbor.tvalue) {
                return
            }
        }
        
        XCTFail("vertex \(neighbor.tvalue!) is not a neighbor of vertex \(source.tvalue!)")
        
    }
    
    
    //reverse a path data structure
    func printPath(_ shortestPath: Path<String>!) {

        
        var reversedPath: Path! = Path<String>()
        var current: Path! = Path<String>()
        
        
        //reverse the sequence of paths
        reversedPath = testGraph.reversePath(shortestPath, source: vertexA)
        current = reversedPath
        
        
        //iterate and print each path sequence
        while (current != nil) {
            print("The path is : \(current.destination.tvalue!) with a total of : \(current.total)..")
            current = current.previous
        }

    }




} //end class
