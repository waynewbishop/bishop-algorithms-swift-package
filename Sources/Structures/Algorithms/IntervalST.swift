//
//  IntervalST.swift
//
//  Description: binary interval search tree
//  Created by Wayne Bishop on 3/8/22.
//

import Foundation

/// Interval search tree for efficient overlap detection
///
/// `IntervalST` (Interval Search Tree) is a binary search tree specialized for storing
/// intervals (ranges) and efficiently finding overlapping intervals. Each node stores a
/// closed range and maintains metadata to enable fast pruning during searches.
///
/// **Purpose:**
/// Solves the interval overlap problem: given a collection of intervals, quickly find all
/// intervals that overlap with a query interval. This is more efficient than checking every
/// interval individually (O(n) → O(log n) average case).
///
/// **Key Features:**
/// - **Binary search tree organization**: Nodes sorted by interval lower bounds
/// - **Max endpoint tracking**: Each node tracks maximum endpoint in its subtree
/// - **Overlap detection**: Automatically detects and flags overlapping intervals
/// - **Efficient searching**: Prunes entire subtrees when no overlap possible
///
/// **Applications:**
/// - Calendar scheduling (finding appointment conflicts)
/// - Genomics (finding overlapping DNA sequences)
/// - Computational geometry (detecting object collisions)
/// - Resource allocation (finding conflicting reservations)
///
/// **Example:**
/// ```swift
/// let tree = IntervalST<Int>()
/// tree.append(5, 10)   // Add interval [5, 10]
/// tree.append(15, 20)  // Add interval [15, 20]
/// tree.append(8, 12)   // Overlaps with [5, 10]
/// root.DFSTraverse()   // Print all intervals in order
/// ```
///
/// **Algorithm:**
/// - **Insertion**: O(log n) average case (BST insertion by lower bound)
/// - **Search**: O(log n + k) where k is the number of overlapping intervals found
/// - **Space**: O(n) for n intervals
///
/// - Note: This implementation uses `ISTNode<T>` for the underlying tree structure.
class IntervalST <T: Comparable> {

    /// Root node of the interval search tree
    var root = ISTNode<T>()


    /// Inserts a new interval into the tree
    ///
    /// This method adds a new interval to the interval search tree while maintaining the
    /// binary search tree invariant (organized by lower bounds) and updating max endpoint
    /// metadata along the insertion path. Also detects and flags overlapping intervals.
    ///
    /// **Algorithm:**
    /// 1. Create closed range from low and high bounds
    /// 2. If tree empty, set as root
    /// 3. Otherwise, traverse tree comparing lower bounds:
    ///    - Update max endpoints along path (enables pruning)
    ///    - Check for overlaps with existing intervals
    ///    - Insert left if lower bound < current, right if greater
    ///
    /// **Overlap Detection:**
    /// During insertion, checks if the new interval overlaps with any existing intervals
    /// using Swift's `overlaps(_:)` method. Sets the `isConflict` flag if overlap detected.
    ///
    /// **Example:**
    /// ```swift
    /// let tree = IntervalST<Int>()
    /// tree.append(5, 10)   // [5, 10]
    /// tree.append(8, 12)   // [8, 12] - overlaps with [5, 10]
    /// tree.append(15, 20)  // [15, 20] - no overlap
    /// ```
    ///
    /// - Parameters:
    ///   - low: Lower bound of the interval (inclusive)
    ///   - high: Upper bound of the interval (inclusive)
    ///
    /// - Complexity: O(log n) average case for balanced tree, O(n) worst case
    ///
    /// - Note: Prints "overlap found.." when inserting an interval that overlaps existing ones
    func append(_ low: T, _ high: T) {

        var current: ISTNode<T> = root

        // Create closed range from bounds
        let range = low...high

        // Handle empty tree - set as root
        guard root.tvalue != nil else {
            root.tvalue = range
            root.max = range.upperBound
            return
        }


        // Create new node for this interval
        let childToUse = ISTNode<T>()
        childToUse.tvalue = range
        childToUse.max = range.upperBound


        // Traverse tree to find insertion position
        while let tvalue = current.tvalue {

            // Update max endpoint as we walk down the tree
            if range.upperBound > tvalue.upperBound {
                current.max = range.upperBound
            }

            // Check for overlap with current node's interval
            if tvalue.overlaps(range) {
                childToUse.isConflict = true
                print("overlap found..")
            }


            // Navigate to left subtree if lower bound is smaller
            if range.lowerBound < tvalue.lowerBound {

                if let lnode = current.left {
                    current = lnode
                    continue
                }
                else {
                    current.left = childToUse
                    break
                }
            }

            // Navigate to right subtree if lower bound is larger
            if range.lowerBound > tvalue.lowerBound {

                if let rnode = current.right {
                    current = rnode
                }
                else {
                    current.right = childToUse
                    break
                }
            }

        }

    }
    
   
    
}
