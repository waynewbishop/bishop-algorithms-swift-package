//
//  Chain.swift
//  Structures
//
//  Created by Wayne Bishop on 8/24/20.
//  Copyright (c) 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A singly-linked list implementation for hash table collision resolution via separate chaining
///
/// This class provides a specialized linked list used by hash tables to handle hash collisions.
/// When multiple keys hash to the same index, they are stored in a chain at that index. Unlike
/// the doubly-linked `LinkedList`, chains only maintain forward links through `next` pointers,
/// optimizing for the append-heavy access pattern of hash table operations.
///
/// Separate chaining is one of two common collision resolution strategies (the other being open
/// addressing). Each hash table bucket contains a `Chain` that stores all key-value pairs that
/// hash to that bucket's index. This allows hash tables to handle collisions gracefully while
/// maintaining average-case O(1) performance for insertions and lookups.
///
/// - Note: This class uses `LLNode` for storage but only uses the `next` pointer, treating it
///         as a singly-linked list. For general-purpose doubly-linked lists, see `LinkedList`.
///
/// - Important: To support type comparisons, the generic type `T` must conform to the `Equatable`
///              protocol to enable collision detection via the `contains(_:)` method.
public class Chain <T: Equatable> {

    /// Reference to the first node in the chain
    private var head = LLNode<T>()

    /// Cached value of the last element in the chain for O(1) tail access
    ///
    /// This optimization avoids traversing the entire chain to find the last value.
    /// Updated whenever elements are appended to the chain.
    private var lastvalue: T?

    /// Creates a new empty chain
    ///
    /// Initializes an empty chain ready to store values. The head node is created but has
    /// no value until the first element is appended.
    public init() {
        //package support
    }

    /// Returns the last value in the chain without traversing
    ///
    /// This computed property provides O(1) access to the tail value by returning the
    /// cached `lastvalue`. Returns `nil` if the chain is empty.
    var last: T? {
        return lastvalue
    }
    
    /// Returns all values stored in the chain as an array
    ///
    /// This property traverses the entire chain from head to tail, collecting all values
    /// into an array. Useful for debugging, testing, or converting chain contents to
    /// standard collection types.
    ///
    /// - Complexity: O(n) where n is the number of elements in the chain. Must visit
    ///              every node to build the complete array.
    ///
    /// - Returns: An array containing all values in the chain in insertion order
    public var values: Array<T> {

        var current: LLNode? = head
        var results = Array<T>()

        while let item = current {
            if let tvalue = item.tvalue {
                results.append(tvalue)
            }
            current = item.next
        }

        return results
    }

    /// Appends a new value to the end of the chain
    ///
    /// This method adds a new value to the tail of the chain, creating a new node and
    /// linking it after the current last node. If the chain is empty, the value is stored
    /// in the head node instead. The `lastvalue` cache is updated to maintain O(1) tail access.
    ///
    /// - Parameter tvalue: The value to append to the chain
    ///
    /// - Complexity: O(n) linear time where n is the number of elements in the chain.
    ///              Must traverse the entire chain to find the last node before appending.
    ///              This could be optimized to O(1) by maintaining a tail pointer, but the
    ///              current implementation prioritizes simplicity for educational purposes.
    public func append(_ tvalue: T) {

        guard head.tvalue != nil else {
           head.tvalue = tvalue
           lastvalue = tvalue
           return
         }

          let childToUse = LLNode<T>()
          childToUse.tvalue = tvalue


          var current: LLNode<T> = head


          //find next position - O(n)
          while let item = current.next {
            current = item
          }

          childToUse.previous = current
          current.next = childToUse

          lastvalue = tvalue
    }
    /// Checks whether a specific value exists in the chain
    ///
    /// This method performs a linear search through the chain, comparing each stored value
    /// against the target value using the `Equatable` protocol's equality operator. This is
    /// essential for hash table collision detection—when inserting a key-value pair, the hash
    /// table calls `contains(_:)` to check if the key already exists in the chain at that bucket.
    ///
    /// - Parameter tvalue: The value to search for in the chain
    ///
    /// - Returns: `true` if the value exists in the chain, `false` otherwise
    ///
    /// - Complexity: O(n) where n is the number of elements in the chain. Must potentially
    ///              visit every node in the worst case (value not found or at the end).
    public func contains(_ tvalue: T) -> Bool {

        var current: LLNode<T>? = head

        //find possible match - O(n)
        while current != nil {
            if let item = current {
                if let chainValue = item.tvalue {
                    if chainValue == tvalue {
                        return true
                    }
                }
                current = item.next
            }
        }

        return false
    }

    /// Prints all values in the chain to the console for debugging
    ///
    /// This method traverses the entire chain and prints each value to standard output.
    /// Useful for debugging hash table collisions by visualizing which values are stored
    /// in each bucket's chain.
    ///
    /// - Complexity: O(n) where n is the number of elements in the chain
    public func printValues() {

        var current: LLNode? = head

        while current != nil {
            if let item = current {
                if let tvalue = item.tvalue {
                    print("chain item is: \(tvalue)")
                }
                current = item.next
            }
        }

    }

}
