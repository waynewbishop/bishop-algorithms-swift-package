//
//  Deque.swift
//
//
//  Created by Wayne Bishop on 4/12/21.
//

import Foundation

/// A double-ended queue (deque, pronounced "deck") implementation
///
/// This class provides a dynamic sequence that supports efficient insertion and removal
/// at both ends. Unlike standard queues (FIFO) or stacks (LIFO), deques allow:
/// - Adding elements to the front (prepend) in O(1) constant time
/// - Adding elements to the back (append) in O(n) linear time
/// - Removing from either end (when combined with appropriate methods)
///
/// Deques are useful for algorithms that need flexible access patterns, such as:
/// - Sliding window algorithms
/// - Palindrome checking
/// - Undo/redo stacks with history navigation
/// - Work-stealing schedulers
///
/// This implementation uses `LLNode<T>` (doubly-linked nodes) for storage, enabling
/// bidirectional traversal and efficient front-end operations.
///
/// - Note: This simplified deque focuses on insertion operations. A full deque implementation
///         would also provide `popFront()` and `popBack()` methods.
public class Deque <T>: Sequence, IteratorProtocol {

    /// Reference to the first node in the deque
    ///
    /// The head node represents the front of the deque where prepend operations occur.
    var head = LLNode<T>()

    /// Internal iterator reference for Sequence protocol conformance
    ///
    /// Tracks the current position during iteration through the deque elements.
    private var iterator: LLNode<T>?

    /// Internal iteration counter for resetting iterator state
    ///
    /// Tracks how many times `next()` has been called to manage iterator lifecycle.
    private var times: Int = 0

    /// Creates a new empty deque
    ///
    /// Initializes an empty deque with a head node ready to accept the first element.
    public init() {
    //playgrounds support
    }
    /// Adds a new item to the beginning (front) of the deque
    ///
    /// This method implements the key deque operation of adding to the front in constant time.
    /// The new element becomes the head and will be the first element accessed during iteration.
    ///
    /// This is more efficient than queue append because it doesn't require traversing to find
    /// the tail—it simply creates a new node and updates the head reference.
    ///
    /// - Parameter item: The value to add to the front of the deque
    ///
    /// - Complexity: O(1) constant time—only updates the head reference
    public func prepend(_ item: T) {

        let childToUse = LLNode<T>()
        childToUse.tvalue = item

        childToUse.next = head
        head = childToUse
    }

    /// Adds a new item to the end (back) of the deque
    ///
    /// This method implements the standard queue-like operation of adding to the rear.
    /// The new element becomes the tail and will be the last element accessed during iteration.
    ///
    /// Unlike `prepend`, this operation requires traversing the entire deque to find the
    /// tail position. A production implementation would maintain a tail reference for O(1)
    /// append performance.
    ///
    /// - Parameter item: The value to add to the end of the deque
    ///
    /// - Complexity: O(n) linear time where n is the number of elements. Must traverse
    ///              the entire deque to find the tail position.
    public func append(_ item: T) {

        guard head.tvalue != nil else {
            head.tvalue = item
            return
        }

        var current: LLNode = head

        let childToUse = LLNode<T>()
        childToUse.tvalue = item


        //find the next position - O(n)
        while let position = current.next {
            current = position
        }

        current.next = childToUse
        childToUse.previous = current

    }

    //MARK: Iterator protocol conformance

    /// Returns the next element in the iteration sequence
    ///
    /// This method implements the `IteratorProtocol` requirement, enabling Swift's for-in
    /// loop syntax and functional operations. The iterator traverses from front to back,
    /// returning values in insertion order (for prepend, reverse chronological; for append,
    /// chronological).
    ///
    /// The iterator state is managed internally via `iterator` and `times` properties.
    /// After exhausting all elements, the iterator automatically resets for potential reuse.
    ///
    /// - Returns: The next value in the deque, or `nil` when iteration completes
    ///
    /// - Complexity: O(1) per call—advances to the next node via single pointer traversal
    public func next() -> T? {

    //print("iterator called..")

    //check starting reference
    if times == 0 {
     iterator = head
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



}
