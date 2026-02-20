//
//  Vertex.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A vertex (node) in a graph data structure
///
/// This class represents a single vertex in a graph, storing its value and maintaining
/// an adjacency list of outgoing edges to neighboring vertices. Vertices are the fundamental
/// building blocks of graph structures, representing entities whose relationships are
/// modeled by edges.
///
/// **Key Properties:**
/// - **Value storage**: Generic `tvalue` holds the vertex's data (city name, user ID, etc.)
/// - **Adjacency list**: Array of `Edge<T>` objects representing outgoing connections
/// - **Traversal support**: `visited` flag for graph algorithms (BFS, DFS, etc.)
/// - **PageRank support**: `rank` array for storing PageRank scores across iterations
/// - **Unique identity**: UUID for equality comparison and graph operations
///
/// **Usage in Graph Algorithms:**
/// - **BFS/DFS traversal**: The `visited` flag prevents revisiting during graph exploration
/// - **Dijkstra's algorithm**: Neighbors provide adjacent vertices for shortest path calculation
/// - **PageRank**: The `rank` array stores authority scores across multiple iterations
/// - **Topological sort**: Traversal state tracking for dependency ordering
///
/// - Note: Vertices are compared by UUID, not by value. Two vertices with the same `tvalue`
///         are considered different if they have different UUIDs.
public class Vertex <T> : Equatable {

    /// The value stored in this vertex
    ///
    /// Generic value representing the vertex's data (e.g., city name, user profile, web page).
    /// Can be nil for empty/sentinel vertices.
    var tvalue: T?

    /// Array of outgoing edges to neighboring vertices (adjacency list)
    ///
    /// Each edge represents a directed connection from this vertex to another vertex,
    /// with an associated weight. For undirected graphs, edges are stored bidirectionally
    /// (both vertices include edges to each other).
    var neighbors = Array<Edge<T>>()

    /// PageRank scores across iterations
    ///
    /// Three-element array storing PageRank values: `[current, next, final]`. Used by
    /// PageRank algorithms to track authority scores as they propagate through the graph
    /// across multiple iterations.
    var rank: Array<Float> = [0, 0, 0]

    /// Traversal flag indicating whether this vertex has been visited
    ///
    /// Used by graph traversal algorithms (BFS, DFS, topological sort) to track which
    /// vertices have been explored. Prevents infinite loops in cyclic graphs.
    var visited: Bool = false

    /// Timestamp of last modification
    ///
    /// Records when this vertex was last updated, useful for cache invalidation or
    /// tracking algorithm execution timing.
    var lastModified = Date()

    /// Unique identifier for this vertex
    ///
    /// Each vertex has a distinct UUID used for equality comparison. This allows two
    /// vertices with identical values to be distinguished as separate entities in the graph.
    let uuid = UUID()


    /// Creates a new empty vertex with nil value
    ///
    /// Initializes a vertex ready to be inserted into a graph. The UUID is automatically
    /// generated. Value should be set after initialization.
   public init() {
        //package support
    }

    /// Creates a new vertex with the specified value
    ///
    /// Initializes a vertex with its data value already set. UUID is automatically generated.
    ///
    /// - Parameter name: The value to store in this vertex
   public init(with name: T) {
       self.tvalue = name
    }


    /// Compares two vertices for equality based on their UUIDs
    ///
    /// Vertices are considered equal only if they have the same UUID, regardless of
    /// their `tvalue` contents. This ensures each vertex maintains unique identity in
    /// the graph even if multiple vertices store the same data.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand vertex
    ///   - rhs: The right-hand vertex
    ///
    /// - Returns: `true` if the vertices have the same UUID, `false` otherwise
    public static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.uuid == rhs.uuid
    }

}

