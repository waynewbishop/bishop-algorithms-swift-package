//
//  HashChain.swift
//
//
//  Created by Wayne Bishop on 8/18/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A hash table demonstrating collision resolution via separate chaining
///
/// This class builds upon `HashSet` by adding collision handling through separate chaining.
/// When multiple elements hash to the same bucket, they're stored in a linked list (`Chain<T>`)
/// at that bucket index, allowing the hash table to store all inserted elements rather than
/// rejecting collisions.
///
/// **How Separate Chaining Works:**
/// - Each bucket stores either nil (empty) or a `Chain<T>` (linked list) of elements
/// - When collision occurs (element hashes to occupied bucket), append to that bucket's chain
/// - Lookups traverse the chain at the computed hash index to find the element
///
/// **Complexity Analysis:**
/// - **Best case:** O(1) when no collisions occur (direct bucket access)
/// - **Worst case:** O(n) when all elements hash to the same bucket (linear chain traversal)
/// - **Average case:** O(1 + α) where α is the load factor (elements/buckets)
///
/// **Educational Progression:**
/// - `HashSet<T: Indexable>` - Basic hashing, no collision handling
/// - `HashChain<T: Indexable>` - This class: adds collision resolution via chaining
/// - `HashTable<Key: Hashable, Value>` - Production hash table with key-value pairs and resizing
///
/// - Note: Uses custom `Indexable` protocol like `HashSet`. For production code with
///         Swift's `Hashable`, see `HashTable<Key, Value>`.
public class HashChain <T: Indexable> {

    /// Number of remaining empty buckets in the hash table
    ///
    /// Decremented when a new chain is created (bucket goes from nil to occupied).
    /// When slots reaches 1, a new bucket is appended to maintain capacity.
    private var slots: Int = 0

    /// Array of bucket chains for storing colliding elements
    ///
    /// Each bucket is either nil (empty) or a `Chain<T>` (linked list) containing all
    /// elements that hashed to that index.
    var buckets: Array<Chain<T>?>


    /// Creates a new empty hash table with separate chaining collision resolution
    ///
    /// Initializes an array of nil bucket chains ready to accept elements via hashing.
    ///
    /// - Parameter capacity: Initial number of buckets, defaults to 20
    public init(capacity: Int = 20) {

        self.buckets = Array<Chain<T>?>(repeatElement(nil, count: capacity))
        self.slots = buckets.capacity

    }


    /// Inserts an element, handling collisions via separate chaining
    ///
    /// This method demonstrates collision resolution through chaining:
    ///
    /// **Case 1: Empty bucket (no collision)**
    /// 1. Creates a new `Chain<T>` (linked list)
    /// 2. Appends the element to the chain
    /// 3. Stores the chain at the computed hash index
    /// 4. Decrements slots and adds bucket if nearly full
    ///
    /// **Case 2: Occupied bucket (collision detected)**
    /// 1. Prints "collision detected!" for educational visibility
    /// 2. Retrieves the existing chain at the hash index
    /// 3. Checks if element already exists (prevents duplicates)
    /// 4. If not duplicate, appends element to the existing chain
    ///
    /// This approach ensures all elements are stored, unlike `HashSet` which rejects
    /// collisions. The trade-off: lookups must traverse the collision chain.
    ///
    /// - Parameter element: The element to insert
    ///
    /// - Complexity: O(1) for empty bucket. O(k) for collision where k is the chain length
    ///              (must check for duplicates before appending).
    public func insert (_ element: T) {

      //compute hash value
      let hvalue = self.hash(element)

        if buckets[hvalue] == nil {

            //new chain
            let chain = Chain<T>()
            chain.append(element)

            buckets[hvalue] = chain
            slots -= 1


            if slots == 1 {
                buckets.append(nil)
                slots = 1
            }

        }
        else {
            print("collision detected!")

            //use existing chain
            if let chain = buckets[hvalue] {
                if chain.contains(element) == false {
                    chain.append(element)
                }
            }

        }

    }



    /// Checks whether an element exists in the hash table
    ///
    /// This method demonstrates collision-aware lookup:
    /// 1. Computes the element's hash value
    /// 2. Retrieves the chain at that bucket index
    /// 3. If bucket is nil (empty), returns false
    /// 4. If chain exists, delegates to `chain.contains()` to search the collision chain
    ///
    /// - Parameter element: The element to search for
    ///
    /// - Returns: `true` if the element exists in the hash table, `false` otherwise
    ///
    /// - Complexity: O(k) where k is the length of the collision chain at the element's
    ///              hash index. Best case O(1) for empty bucket or single-element chain.
     public func contains(_ element: T) -> Bool {

      //compute hash value
      let hvalue = self.hash(element)

        guard let chain = buckets[hvalue] else {
            return false
        }

      return chain.contains(element)

    }




    /// Computes the hash index for an element using modulo-based hashing
    ///
    /// This method uses the same hash function as `HashSet`:
    /// 1. Uses the element's `asciiRepresentation` (required by `Indexable` protocol)
    /// 2. Computes `asciiRepresentation % buckets.count` to map to a valid bucket index
    ///
    /// The difference from `HashSet`: when this hash function produces collisions,
    /// `HashChain` handles them gracefully via separate chaining rather than rejecting
    /// the insertion.
    ///
    /// - Parameter element: The element to hash
    ///
    /// - Returns: A bucket index in the range `0..<buckets.count`
    ///
    /// - Complexity: O(1) constant time
     private func hash (_ element: T) -> Int {

        /*
         conforming indexable objects are required to have an
         ascii representation to be used by the hash algorithm.
         */

        var remainder: Int = 0
        remainder = element.asciiRepresentation % buckets.count
        return remainder
    }

}
