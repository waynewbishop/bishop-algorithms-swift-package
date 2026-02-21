// Copyright 2026 Wayne W Bishop. All rights reserved.
//
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.

import Foundation

/// A path in Dijkstra's shortest path algorithm, tracking cumulative cost and route
///
/// This class represents a candidate path being explored during Dijkstra's shortest path
/// algorithm. Each path tracks its destination vertex, cumulative cost from the source,
/// and a reference to the previous path segment, forming a linked list that traces the
/// complete route.
///
/// **Memoization in Dijkstra's Algorithm:**
/// Path objects implement a form of memoization by caching the best-known cumulative cost
/// to reach each vertex as the algorithm explores the frontier. Rather than recomputing
/// costs from scratch, each Path stores:
/// - The lowest total cost discovered so far to reach its destination
/// - The route that achieved this cost (via the `previous` chain)
///
/// This memoization enables Dijkstra's algorithm to efficiently build up shortest paths by
/// reusing previously computed partial routes. When a better path to a vertex is discovered,
/// a new Path object replaces the old one in the frontier, updating the memoized cost.
///
/// **Role in Dijkstra's Algorithm:**
/// Paths are the fundamental unit stored in the "frontier" (priority queue of unexplored
/// paths). The algorithm repeatedly:
/// 1. Extracts the shortest path from the frontier (via `PathHeap`)
/// 2. Examines the destination vertex's neighbors
/// 3. Creates new path objects for each neighbor, extending the current path
/// 4. Adds these new paths back to the frontier (memoizing improved costs)
///
/// **Path Reconstruction:**
/// The `previous` pointer chains path segments together in reverse order. To reconstruct
/// the full route from source to destination, traverse backward through `previous` links
/// until reaching the source (where `previous` is nil).
///
/// Example path chain for route A → B → C:
/// ```
/// Path(destination: C, total: 15, previous: →)
///                                           ↓
///                       Path(destination: B, total: 10, previous: →)
///                                                                   ↓
///                                           Path(destination: A, total: 0, previous: nil)
/// ```
///
/// - Note: Used exclusively by Dijkstra's algorithm and managed by `PathHeap` for
///         efficient minimum-cost path extraction.
public class Path <T> {

    /// Cumulative cost from source vertex to the destination of this path
    ///
    /// Represents the total weight of all edges traversed from the source to reach
    /// the `destination` vertex. In Dijkstra's algorithm, paths are prioritized by
    /// this total cost (shortest total = highest priority).
    var total: Int

    /// The vertex reached by following this path
    ///
    /// Represents the endpoint of this path segment. In Dijkstra's algorithm, this is
    /// the vertex whose neighbors will be explored next if this path is selected from
    /// the frontier.
    var destination: Vertex<T>

    /// Reference to the previous path segment, forming a linked chain
    ///
    /// Points to the path that preceded this one, creating a reverse-linked list from
    /// destination back to source. When `nil`, this path represents the source vertex
    /// (starting point with total cost 0).
    var previous: Path?


    /// Creates a new empty path with zero cost and no destination
    ///
    /// Initializes a path ready to be configured with a destination vertex, total cost,
    /// and previous path link. Used internally by Dijkstra's algorithm during path
    /// exploration and extension.
    public init(){
        destination = Vertex<T>()
        total = 0
    }

}
