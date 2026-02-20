//
//  Heap.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 9/7/17.
//  Copyright © 2017 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A generic binary heap data structure supporting both min-heap and max-heap modes
///
/// This class implements an array-backed binary heap, a complete binary tree that maintains
/// the heap property:
/// - **Min-heap**: Every parent is ≤ its children (minimum element at root)
/// - **Max-heap**: Every parent is ≥ its children (maximum element at root)
///
/// Heaps excel at priority queue operations (finding/removing min or max) and heap sort.
/// The array representation uses implicit parent-child relationships:
/// - Parent of index i: `(i - 1) / 2`
/// - Left child of index i: `2i + 1`
/// - Right child of index i: `2i + 2`
///
/// This eliminates pointer overhead while maintaining O(log n) insert and extract operations
/// via bottom-up heapification.
///
/// - Note: This heap only supports insertion (`enQueue`). For a full priority queue with
///         extraction, see `PathHeap` which adds `deQueue()` functionality.
public class Heap<T: Comparable> {

    /// Array storing heap elements in level-order
    ///
    /// Elements are arranged to satisfy the heap property. Index 0 contains the root
    /// (minimum for min-heap, maximum for max-heap).
    var items: Array<T>

    /// The heap type determining comparison order (min or max)
    ///
    /// Controls whether we maintain min-heap (smaller values bubble up) or max-heap
    /// (larger values bubble up) property during heapification.
    private var heapType: HeapType

    /// Creates a new empty heap of the specified type
    ///
    /// Initializes an empty heap configured as either min-heap or max-heap. Defaults to
    /// min-heap if no type is specified.
    ///
    /// - Parameter type: The heap type (`.min` or `.max`), defaults to `.min`
    public init(type: HeapType = .min) {

        items = Array<T>()
        heapType = type
    }

    /// Returns all heap elements in their array order
    ///
    /// Provides access to the internal array representation. Elements are in level-order
    /// (breadth-first) but NOT sorted order—use heapsort for sorted output.
    ///
    /// - Returns: The complete array of heap elements
    var sequence: Array<T> {
        return self.items
    }

    /// The number of elements currently in the heap
    ///
    /// - Complexity: O(1)
    ///
    /// - Returns: The count of elements in the heap
    public var count: Int {
        return self.items.count
    }

    /// Returns the root element (min or max) without removing it
    ///
    /// For min-heap, returns the minimum element. For max-heap, returns the maximum.
    /// The root is always at index 0 in the array representation.
    ///
    /// - Returns: The root element, or `nil` if the heap is empty
    ///
    /// - Complexity: O(1) constant time—direct array access
    public func peek() -> T? {

        if items.count > 0 {
            return items[0] //the min or max value - O(1)
        }
        else {
            return nil
        }
    }
    /// Inserts a new element and restores heap property via bottom-up heapification
    ///
    /// This method implements the standard heap insertion algorithm:
    /// 1. Append the new element to the end of the array (maintains complete tree property)
    /// 2. "Bubble up" the element by comparing with its parent
    /// 3. Swap with parent if heap property is violated (child < parent for min-heap)
    /// 4. Repeat until reaching root or finding correct position
    ///
    /// For min-heap, smaller values bubble toward the root. For max-heap, larger values
    /// bubble toward the root.
    ///
    /// - Parameter key: The value to insert into the heap
    ///
    /// - Complexity: O(log n) where n is the number of elements. Must potentially bubble
    ///              up through log n levels (the height of the complete binary tree).
    public func enQueue(_ key: T) {
        
        items.append(key)
        
        
        var childIndex: Float = Float(items.count) - 1
        var parentIndex: Int = 0
        
        
        //calculate parent index
        if  childIndex != 0 {
            parentIndex = Int(floorf((childIndex - 1) / 2))   //todo: make this a method!
        }
        
        
        var childToUse: T
        var parentToUse: T
        
        
        //use the bottom-up approach
        while childIndex != 0 {
            
            
            childToUse = items[Int(childIndex)]
            parentToUse = items[parentIndex]
            
            
            //heapify depending on type
            switch heapType {

            case .min:

                //swap child and parent positions
                if childToUse <= parentToUse {
                    items.swapAt(parentIndex, Int(childIndex))
                }
                else {
                    break
                }

            case .max:

                //swap child and parent positions
                if childToUse >= parentToUse {
                    items.swapAt(parentIndex, Int(childIndex))
                }
                else {
                    break
                }

            }
            
            
            //reset indices
            childIndex = Float(parentIndex)
            
            
            if  childIndex != 0 {
                parentIndex = Int(floorf((childIndex - 1) / 2))
            }
            
            
        } //end while
        
        
    } //end function
    
}
