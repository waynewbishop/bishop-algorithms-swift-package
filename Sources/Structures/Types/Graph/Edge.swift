//
//  Edge.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A directed edge connecting two vertices in a graph
///
/// This class represents a weighted directed edge from one vertex to another. Edges are
/// the fundamental relationships in graphs, modeling connections like roads between cities,
/// friendships between users, or links between web pages.
///
/// **Graph Representation:**
/// Each vertex maintains an array of `Edge<T>` objects in its adjacency list. Each edge
/// stores the destination vertex (`neighbor`) and the cost of traversing that edge (`weight`).
///
/// **Directed vs. Undirected Graphs:**
/// - **Directed**: Edge from A→B exists in A's neighbors list only
/// - **Undirected**: Edge A↔B requires creating two edges (A→B and B→A)
///
/// **Weight Semantics:**
/// The weight can represent various metrics depending on the application:
/// - Distance (kilometers between cities)
/// - Cost (toll fees, flight prices)
/// - Time (travel duration)
/// - Capacity (network bandwidth)
/// - Authority (link strength for PageRank)
///
/// **Usage in Algorithms:**
/// - **Dijkstra's shortest path**: Weight determines path cost
/// - **BFS traversal**: Weight typically ignored (unweighted graph)
/// - **PageRank**: Weight can model link strength (usually uniform)
///
/// - Note: For unweighted graphs, set all weights to 1 or ignore the weight property.
public class Edge <T> {

    /// The destination vertex this edge points to
    ///
    /// Represents the "neighbor" or "adjacent vertex" reachable via this edge. In a
    /// road network, this would be the destination city.
    var neighbor: Vertex<T>

    /// The cost of traversing this edge
    ///
    /// Represents the weight, distance, or cost associated with this connection. Used
    /// by shortest path algorithms to compute optimal routes.
    var weight: Int

    /// Creates a new edge with default weight of 0 and empty neighbor
    ///
    /// Initializes an edge ready to be configured with a destination vertex and weight.
    /// Typically used internally by the `Graph` class during edge creation.
    init() {
        weight = 0
        self.neighbor = Vertex<T>()
    }

}

