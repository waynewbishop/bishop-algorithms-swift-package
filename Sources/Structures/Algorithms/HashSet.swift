//
//  HashSet.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 5/18/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A basic hash table implementation demonstrating set operations without collision handling
///
/// This class provides an introductory hash table (set-like) that stores unique elements
/// with O(1) average insertion and lookup. It demonstrates fundamental hashing concepts:
/// - Computing hash values to determine bucket placement
/// - Direct indexing into an array for constant-time access
/// - Dynamic capacity management (adding buckets when nearly full)
///
/// **Educational Purpose:**
/// This is the **simplest** hash table in the package, intentionally omitting collision
/// handling to focus on core hashing mechanics. When two elements hash to the same index,
/// insertion fails (returns `false`). This limitation demonstrates why collision resolution
/// is necessary for production hash tables.
///
/// **Progression Path:**
/// - `HashSet<T: Indexable>` - This class: basic hashing, no collisions
/// - `HashChain<T: Indexable>` - Adds collision resolution via separate chaining
/// - `HashTable<Key: Hashable, Value>` - Full production hash table with key-value pairs
///
/// - Note: Uses custom `Indexable` protocol requiring `asciiRepresentation`. For production
///         code using Swift's built-in `Hashable`, see `HashTable`.
public class HashSet <T: Indexable> {


    /// Array of buckets for storing elements
    ///
    /// Each bucket can hold zero (nil) or one element. When an element hashes to an index,
    /// it's stored directly at that index. This simple approach provides O(1) access but
    /// cannot handle collisions (if two elements hash to the same index, insertion fails).
    private var buckets: Array<T?>

    /// Number of remaining empty slots in the hash table
    ///
    /// Decremented on successful insertion. When slots reaches 1, a new bucket is appended
    /// to prevent the table from becoming completely full.
    private var slots: Int = 0


    /// Creates a new empty hash set with the specified initial capacity
    ///
    /// Initializes an array of nil buckets ready to accept elements via hashing.
    ///
    /// - Parameter capacity: Initial number of buckets, defaults to 20
    public init(capacity: Int = 20) {

        self.buckets = Array<T?>(repeatElement(nil, count: capacity))
        self.slots = buckets.capacity
    }


    /// Inserts an element if its hash index is unoccupied
    ///
    /// This method demonstrates basic hashing without collision resolution:
    /// 1. Computes hash value for the element
    /// 2. Checks if bucket at that index is empty
    /// 3. If empty, stores element and decrements slots counter
    /// 4. If only 1 slot remains, appends a new bucket to maintain capacity
    ///
    /// **Collision Behavior:**
    /// If the computed hash index is already occupied, the method returns `false` without
    /// inserting. The comment "//separate chaining.." indicates where collision handling
    /// would be implemented (see `HashChain` for the solution).
    ///
    /// - Parameter element: The element to insert
    ///
    /// - Returns: `true` if insertion succeeded, `false` if hash collision prevented insertion
    ///
    /// - Complexity: O(1) constant time for hash computation and array access
    public func insert (_ element: T) -> Bool {

      //compute hash value
      let hvalue = self.hash(element)

        if buckets[hvalue] == nil {
            buckets[hvalue] = element
            slots -= 1


            //determine if more slots are needed
            if slots == 1 {
                buckets.append(nil)
                slots = 1
            }

            return true
        }

        else {
            //separate chaining..
        }

      return false
    }


    /// Checks whether an element exists in the hash set
    ///
    /// This method computes the element's hash value and checks if the bucket at that
    /// index is non-nil. Because there's no collision handling, this only works correctly
    /// if the element was successfully inserted (no collision occurred during insertion).
    ///
    /// - Parameter element: The element to search for
    ///
    /// - Returns: `true` if the bucket at the element's hash index is occupied,
    ///           `false` otherwise
    ///
    /// - Complexity: O(1) constant time
    public func contains(_ element: T) -> Bool {

      //compute hash value
      let hvalue = self.hash(element)

      guard buckets[hvalue] != nil else {
        return false
      }

      return true
    }


    /// Unconditionally inserts an element (delegates to insert)
    ///
    /// This method is a convenience wrapper around `insert(_:)` that provides set-like
    /// "update" semantics. Returns the same result as `insert(_:)`.
    ///
    /// - Parameter element: The element to insert/update
    ///
    /// - Returns: `true` if insertion succeeded, `false` if collision prevented insertion
    ///
    /// - Complexity: O(1) constant time (delegates to `insert(_:)`)
    public func update(_ element: T) -> Bool {
        let result: Bool = self.insert(element)
        return result
    }


    /// Computes the hash index for an element using modulo-based hashing
    ///
    /// This method implements a simple hash function:
    /// 1. Uses the element's `asciiRepresentation` (required by `Indexable` protocol)
    /// 2. Computes `asciiRepresentation % buckets.count` to map to a valid bucket index
    ///
    /// The modulo operation ensures the result is in range `0..<buckets.count`. Different
    /// elements with the same modulo result will collide (hash to the same index).
    ///
    /// - Parameter element: The element to hash
    ///
    /// - Returns: A bucket index in the range `0..<buckets.count`
    ///
    /// - Complexity: O(1) constant time
    private func hash(_ element: T) -> Int {

        /*
         conforming indexable objects are required to have an
         ascii representation to be used by the hash algorithm.
         */

        var remainder: Int = 0
        remainder = element.asciiRepresentation % buckets.count
        return remainder
    }

}

