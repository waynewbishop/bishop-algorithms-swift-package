//
//  Queue.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/11/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A generic queue implementation using a singly-linked list
///
/// This class provides a First-In-First-Out (FIFO) data structure where elements are added
/// at the back (enqueue) and removed from the front (dequeue). Queues are fundamental to
/// algorithms including breadth-first search, task scheduling, buffering, and message processing.
///
/// The dequeue operation executes in constant O(1) time by maintaining a reference to the
/// front node. However, enqueue requires O(n) linear time to traverse to the tail position
/// in this implementation. This trade-off prioritizes simplicity for educational purposes—a
/// production queue would maintain a tail reference for O(1) enqueue.
///
/// This implementation conforms to `Sequence` and `IteratorProtocol`, enabling Swift's
/// for-in loop syntax and functional programming operations.
///
/// - Note: This class uses `Node<T>` for storage (singly-linked list). For LIFO behavior
///         (Last-In-First-Out), see `Stack`.
public class Queue<T>: Sequence, IteratorProtocol {

    /// Reference to the front node in the queue
    ///
    /// The top node contains the oldest enqueued value, which will be returned by the
    /// next `deQueue()` call. This represents the "front" of the queue.
    var top = Node<T>()

    /// Count of elements currently in the queue
    ///
    /// Maintained incrementally during enqueue/dequeue operations to provide O(1) count
    /// access without traversing the entire queue.
    private var counter: Int = 0

    /// Internal iterator reference for Sequence protocol conformance
    ///
    /// Tracks the current position during iteration through the queue elements.
    private var iterator: Node<T>?

    /// Internal iteration counter for resetting iterator state
    ///
    /// Tracks how many times `next()` has been called to manage iterator lifecycle.
    private var times: Int = 0

    /// Creates a new empty queue
    ///
    /// Initializes a queue with an empty top node ready to accept the first enqueued value.
    public init() {
        //dependency support
    }

    /// The number of elements currently in the queue
    ///
    /// This computed property returns the cached counter value, providing O(1) constant-time
    /// access to the queue size without needing to traverse the structure.
    ///
    /// - Complexity: O(1)
    public var count: Int {
        return counter
    }

    /// Returns the front element without removing it from the queue
    ///
    /// This method provides read-only access to the oldest enqueued value (the element
    /// at the front of the queue). The queue structure remains unchanged—use `deQueue()`
    /// to remove the front element.
    ///
    /// - Returns: The value at the front of the queue, or `nil` if the queue is empty
    ///
    /// - Complexity: O(1) constant time—accesses only the top node reference
    public func peek() -> T? {
        return top.tvalue
    }

    /// Checks whether the queue contains any elements
    ///
    /// This method provides a semantic way to test for emptiness. Equivalent to
    /// checking `count == 0`, but more readable and explicit about intent.
    ///
    /// - Returns: `true` if the queue contains zero elements, `false` otherwise
    ///
    /// - Complexity: O(1) constant time—checks only the top node value
    public func isEmpty() -> Bool {

        guard top.tvalue != nil else {
            return true
        }

        return false
    }

    //MARK: Queuing Functions

    /// Adds a new value to the back of the queue
    ///
    /// This method implements the fundamental queue operation of enqueuing, which adds an
    /// element to the tail position. The new value will be returned by `deQueue()` only after
    /// all previously enqueued values have been dequeued, preserving FIFO order.
    ///
    /// The implementation traverses the entire queue to find the tail position before appending
    /// the new node. This results in O(n) linear time complexity. A production implementation
    /// would maintain a tail reference to achieve O(1) enqueue performance.
    ///
    /// - Parameter key: The value to add to the back of the queue
    ///
    /// - Complexity: O(n) linear time where n is the number of elements in the queue.
    ///              Must traverse the entire queue to find the tail position.
    public func enQueue(_ key: T) {


        //trivial case
        guard top.tvalue != nil else {
            top.tvalue = key
            counter += 1
            return
        }

        let childToUse = Node<T>()
        var current = top


        //find next position - O(n)
        while let next = current.next {
            current = next
        }


        //append new item
        childToUse.tvalue = key
        current.next = childToUse
        counter += 1
    }

    /// Removes and returns the front element from the queue
    ///
    /// This method implements the fundamental queue operation of dequeuing, which removes
    /// the oldest enqueued value from the front and returns it to the caller. The next element
    /// (if any) becomes the new front of the queue.
    ///
    /// If the queue is empty, this method returns `nil` without modifying the structure.
    ///
    /// - Returns: The value that was at the front of the queue, or `nil` if empty
    ///
    /// - Complexity: O(1) constant time—updates only the top reference and counter
    public func deQueue() -> T? {


        //trivial case
        guard top.tvalue != nil else {
            return nil
        }


        //retrieve current item
        let item = top.tvalue


        //queue next item
        if let next = top.next {
          top = next
          counter -= 1
        }

        else {
          top.tvalue = nil
          counter = 0
        }


        return item

    }

    //MARK: Iterator protocol conformance

    /// Returns the next element in the iteration sequence
    ///
    /// This method implements the `IteratorProtocol` requirement, enabling Swift's for-in
    /// loop syntax and functional operations. The iterator traverses from front to back,
    /// returning values in FIFO order (same order as repeated `deQueue()` calls).
    ///
    /// The iterator state is managed internally via `iterator` and `times` properties.
    /// After exhausting all elements, the iterator automatically resets for potential reuse.
    ///
    /// - Returns: The next value in the queue, or `nil` when iteration completes
    ///
    /// - Complexity: O(1) per call—advances to the next node via single pointer traversal
     public func next() -> T? {

         print("iterator called..")

         //check starting reference
         if times == 0 {
             iterator = top
         }


         //assign next instance
         if let item = iterator {
             if let tvalue = item.tvalue {
                 iterator = item.next
                 times += 1
                 return tvalue
             }
         }

         //reset timer
         times = 0

         return nil

     }


} //end class

