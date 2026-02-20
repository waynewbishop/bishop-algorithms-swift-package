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

/// Node for interval search tree data structure
///
/// `ISTNode` represents a single node in an interval search tree, a specialized binary
/// search tree that stores ranges (intervals) and efficiently detects overlapping intervals.
/// Each node contains a closed range value plus metadata for efficient overlap detection.
///
/// **Purpose:**
/// Interval search trees solve the "interval overlap" problem: given a set of intervals,
/// quickly find all intervals that overlap with a query interval. Common applications:
/// - Calendar scheduling (finding conflicting appointments)
/// - Genomic analysis (finding overlapping DNA sequences)
/// - Computational geometry (detecting colliding objects)
///
/// **Node Structure:**
/// - **tvalue**: The interval stored at this node (closed range)
/// - **max**: Maximum endpoint in this subtree (enables pruning during search)
/// - **isConflict**: Flag indicating if this interval overlaps with another
/// - **left/right**: Binary tree child pointers
///
/// **Example:**
/// ```swift
/// let node = ISTNode<Int>()
/// node.tvalue = 5...10  // Stores interval [5, 10]
/// node.max = 15         // Subtree contains intervals up to 15
/// ```
///
/// - Note: Used by `IntervalST<T>` to build the complete interval search tree.
class ISTNode <T: Comparable> {

    /// The closed range interval stored at this node
    var tvalue: ClosedRange<T>?

    /// Maximum endpoint value in this node's subtree
    ///
    /// This optimization enables efficient pruning during interval searches. If a query
    /// interval's lower bound exceeds this max value, we can skip the entire subtree.
    var max: T?

    /// Flag indicating whether this interval overlaps with another in the tree
    var isConflict: Bool = false

    /// Left child node (intervals with smaller lower bounds)
    var left: ISTNode?

    /// Right child node (intervals with larger lower bounds)
    var right: ISTNode?
    


    /// Performs depth-first in-order traversal of the interval tree
    ///
    /// This method traverses the interval search tree in sorted order (by lower bounds)
    /// using depth-first search with in-order traversal pattern:
    /// 1. Process left subtree (smaller intervals)
    /// 2. Process current node
    /// 3. Process right subtree (larger intervals)
    ///
    /// **Algorithm:**
    /// Standard recursive DFS in-order traversal. Since the tree is organized by lower
    /// bounds, this prints intervals in ascending order of their start points.
    ///
    /// **Example Output:**
    /// ```
    /// ...the range is: 5 - 10..
    /// ...the range is: 12 - 15..
    /// ...the range is: 20 - 25..
    /// ```
    ///
    /// - Complexity: O(n) where n is the number of intervals in the tree
    ///
    /// - Note: Prints each interval's lower and upper bounds during traversal
    public func DFSTraverse() {

        // Check if node has valid interval
        guard let tvalue = self.tvalue else {
            print("no key provided..")
            return
        }

        // Process the left subtree (smaller intervals)
        if let left = self.left {
            left.DFSTraverse()
        }

        // Process current node
        print("...the range is: \(tvalue.lowerBound) - \(tvalue.upperBound)..")

        // Process the right subtree (larger intervals)
        if let right = self.right {
            right.DFSTraverse()
        }

    }

}
