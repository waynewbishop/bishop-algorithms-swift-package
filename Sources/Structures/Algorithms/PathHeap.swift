//
//  PathHeap.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 8/9/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A specialized min-heap for managing graph shortest paths (frontier in Dijkstra's algorithm)
///
/// This class implements a priority queue specifically designed for pathfinding algorithms like
/// Dijkstra's shortest path. It maintains a min-heap of `Path<T>` objects, where the "minimum"
/// is determined by the path's total cost (`total` property).
///
/// In Dijkstra's algorithm, the frontier is the set of unexplored paths we're considering.
/// The PathHeap efficiently answers "what's the shortest unexplored path?" in O(1) time via
/// `peek()`, while `enQueue()` adds new paths and `deQueue()` removes the shortest.
///
/// Unlike the generic `Heap<T>`, this specialized heap:
/// - Only supports min-heap mode (always finds minimum-cost path)
/// - Compares paths by their `total` cost rather than the path object itself
/// - Provides `deQueue()` to remove the minimum (the generic Heap lacks extraction)
///
/// - Note: The current `deQueue()` implementation is O(n) due to shifting array elements.
///         A production implementation would use top-down heapification for O(log n) extraction.
public class PathHeap <T> {

    /// Array storing paths in min-heap order
    ///
    /// Paths are arranged so that the shortest path (minimum total cost) is always at index 0.
    private var heap: Array<Path<T>>

    /// Creates a new empty path heap
    ///
    /// Initializes an empty min-heap ready to manage paths for shortest-path algorithms.
    public init() {
        heap = Array<Path<T>>()
    }


    /// The number of paths currently in the frontier
    ///
    /// Returns the count of unexplored paths being tracked in this priority queue.
    /// Useful for checking if there are more paths to explore in Dijkstra's algorithm.
    ///
    /// - Complexity: O(1) constant time—direct array count access
    public var count: Int {
        return self.heap.count
    }


    /// Returns the shortest path without removing it from the frontier
    ///
    /// In Dijkstra's algorithm, this answers "what's the next shortest path to explore?"
    /// The min-heap property guarantees the shortest path is always at index 0.
    ///
    /// - Returns: The path with minimum total cost, or `nil` if the frontier is empty
    ///
    /// - Complexity: O(1) constant time—direct array access to root element
    public func peek() -> Path<T>? {

        if heap.count > 0 {
           return heap[0] //the shortest path: O(1) - constant time
        }
        else {
            return nil
        }

    }
    


    /// Removes and discards the shortest path from the frontier
    ///
    /// This method extracts the minimum-cost path (at index 0) from the heap. In Dijkstra's
    /// algorithm, this represents "exploring" the shortest known path—processing its vertex
    /// and considering its neighbors for addition to the frontier.
    ///
    /// - Note: The current implementation uses `Array.remove(at: 0)`, which is O(n) due to
    ///         shifting all remaining elements. A production priority queue would restore
    ///         the heap property via top-down heapification for O(log n) extraction.
    ///
    /// - Complexity: O(n) linear time due to array element shifting
    public func deQueue() {

        if heap.count > 0 {
            heap.remove(at: 0)
        }

    }
    

    /// Inserts a new path and restores min-heap property via bottom-up heapification
    ///
    /// This method implements the standard heap insertion algorithm specialized for paths:
    /// 1. Append the new path to the end of the array (maintains complete tree property)
    /// 2. "Bubble up" the path by comparing its `total` cost with its parent's cost
    /// 3. Swap with parent if child cost < parent cost (min-heap property)
    /// 4. Repeat until reaching root or finding correct position
    ///
    /// In Dijkstra's algorithm, this adds a newly discovered path to the frontier of
    /// unexplored paths. The heapification ensures the shortest path is always retrievable
    /// in O(1) time via `peek()`.
    ///
    /// - Parameter key: The path to insert into the frontier
    ///
    /// - Complexity: O(log n) where n is the number of paths. Must potentially bubble up
    ///              through log n levels (the height of the complete binary tree).
    public func enQueue(_ key: Path<T>) {


        heap.append(key)


        var childIndex: Float = Float(heap.count) - 1
        var parentIndex: Int = 0


        //calculate parent index
        if childIndex != 0 {
            parentIndex = Int(floorf((childIndex - 1) / 2))
        }


        var childToUse: Path<T>
        var parentToUse: Path<T>


        //use the bottom-up approach
        while childIndex != 0 {


            childToUse = heap[Int(childIndex)]
            parentToUse = heap[parentIndex]


            //swap child and parent positions
            if childToUse.total < parentToUse.total {
                heap.swapAt(parentIndex, Int(childIndex))
            }
            else {
                break
            }

            //reset indices
            childIndex = Float(parentIndex)


            if childIndex != 0 {
                parentIndex = Int(floorf((childIndex - 1) / 2))
            }



        } //end while


    } //end function

    
    
}
