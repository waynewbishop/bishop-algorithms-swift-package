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

// MARK: - Supporting Types

/// A node for building separate chaining collision resolution in hash tables
///
/// This class implements a singly-linked list node used to handle hash collisions via
/// separate chaining. When multiple keys hash to the same bucket, they're stored as a
/// linked list at that bucket index.
///
/// Each node stores both a key and its associated value, plus a reference to the next
/// node in the chain (if any). This allows efficient traversal through all keys that
/// collided at the same hash index.
///
/// - Note: Used exclusively by `HashTable` for collision resolution. For general-purpose
///         linked list nodes, see `Node<T>` or `LLNode<T>`.
public class HashNode<Key: Hashable, Value> {
    /// The unique key for this key-value pair
    public let key: Key

    /// The value associated with this key
    public var value: Value

    /// Reference to the next node in the collision chain, or nil if this is the last node
    public var next: HashNode<Key, Value>?

    /// Creates a new hash node with the specified key and value
    ///
    /// - Parameters:
    ///   - key: The unique key for this key-value pair
    ///   - value: The value to associate with this key
    public init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}

/// Result codes for hash table operations
///
/// These cases describe the outcome of hash table insert operations, providing feedback
/// about whether a collision occurred, a value was updated, or the operation succeeded
/// without conflicts.
public enum HashTableResult {
    /// Operation completed successfully without collision
    case success

    /// Operation succeeded but a hash collision occurred (resolved via chaining)
    case collision

    /// Key was not found in the hash table
    case notFound

    /// Key already existed; its value was updated to the new value
    case updated
}


// MARK: - Hash Table Implementation

/// A production-ready hash table with dynamic resizing and collision handling
///
/// This class implements a complete hash table (dictionary) that stores key-value pairs
/// with O(1) average-case performance for insertions, lookups, and deletions. It demonstrates
/// three advanced features beyond basic hash tables:
///
/// **1. Collision Resolution via Separate Chaining**
/// When multiple keys hash to the same bucket, they're stored in a linked list at that index.
/// This handles collisions elegantly without needing open addressing or probe sequences.
///
/// **2. Dynamic Resizing with Load Factor Management**
/// The table automatically doubles its capacity when the load factor (size/capacity) exceeds
/// 0.75. This maintains O(1) average performance by keeping collision chains short. Resizing
/// triggers a full rehash of all existing elements.
///
/// **3. Full Dictionary API**
/// Provides subscript syntax (`table[key] = value`), contains checking, removal, and all
/// standard CRUD operations expected from a modern hash table implementation.
///
/// This is the most advanced hash table in the package. For educational progression:
/// - `HashSet<T: Indexable>` - Basic set with no collision handling
/// - `HashChain<T: Indexable>` - Intermediate with collision handling
/// - `HashTable<Key: Hashable, Value>` - Production-ready with full features (this class)
///
/// - Note: Uses Swift's built-in `Hashable` protocol rather than custom `Indexable`,
///         making it compatible with all Swift standard library types.
public class HashTable<Key: Hashable, Value> {
    /// Array of bucket heads for separate chaining
    ///
    /// Each bucket is either nil (empty) or the head of a linked list of `HashNode` objects.
    /// Index is computed via `hashIndex(for:)` using the key's hash value modulo capacity.
    private var buckets: [HashNode<Key, Value>?]

    /// Current capacity (number of buckets) in the hash table
    ///
    /// Doubles whenever load factor exceeds `maxLoadFactor`. Always a power of 2 for
    /// efficient modulo operations.
    private var capacity: Int

    /// Number of key-value pairs currently stored in the hash table
    ///
    /// Incremented on successful insertion, decremented on removal. Used to calculate
    /// load factor for resize decisions.
    private var size: Int = 0

    /// Load factor threshold triggering automatic resizing
    ///
    /// When `size/capacity > 0.75`, the table doubles capacity and rehashes all elements.
    /// This keeps collision chains short for O(1) average performance.
    private let maxLoadFactor: Double = 0.75

    /// Creates a new empty hash table with the specified initial capacity
    ///
    /// Initializes an empty hash table ready to accept key-value pairs. The capacity
    /// determines the number of buckets for distributing keys via hashing.
    ///
    /// - Parameter capacity: Initial number of buckets, defaults to 16
    public init(capacity: Int = 16) {
        self.capacity = capacity
        self.buckets = Array(repeating: nil, count: capacity)
    }

    /// The number of key-value pairs currently stored in the hash table
    ///
    /// - Complexity: O(1) constant time
    public var count: Int {
        return size
    }

    /// Whether the hash table contains any key-value pairs
    ///
    /// - Returns: `true` if the table is empty, `false` otherwise
    ///
    /// - Complexity: O(1) constant time
    public var isEmpty: Bool {
        return size == 0
    }

    /// The current load factor (ratio of elements to buckets)
    ///
    /// Load factor = size / capacity. Higher load factors mean longer collision chains
    /// and slower performance. The table automatically resizes when load factor exceeds
    /// `maxLoadFactor` (0.75) to maintain O(1) average performance.
    ///
    /// - Returns: A value between 0.0 (empty) and 1.0+ (potentially many collisions)
    ///
    /// - Complexity: O(1) constant time
    public var loadFactor: Double {
        return Double(size) / Double(capacity)
    }
}


// MARK: - Hash Functions

extension HashTable {
    /// Computes the bucket index for a given key using Swift's built-in hash value
    ///
    /// This method maps a key to a bucket index by taking the key's hash value modulo
    /// the current capacity. The `abs()` ensures negative hash values are handled correctly.
    ///
    /// Formula: `index = abs(key.hashValue) % capacity`
    ///
    /// - Parameter key: The key to hash
    ///
    /// - Returns: A bucket index in the range `0..<capacity`
    ///
    /// - Complexity: O(1) constant time—direct hash computation and modulo operation
    private func hashIndex(for key: Key) -> Int {
        return abs(key.hashValue) % capacity
    }

    /// Alternative hash function with potentially better distribution characteristics
    ///
    /// This method uses Swift's `Hasher` type for more control over the hashing process.
    /// The `Hasher` combines the key and finalizes to produce a hash value with good
    /// distribution properties, reducing collision likelihood.
    ///
    /// This demonstrates that different hash functions can be used depending on the
    /// collision patterns observed. Currently unused in favor of `hashIndex(for:)`.
    ///
    /// - Parameter key: The key to hash
    ///
    /// - Returns: A bucket index in the range `0..<capacity`
    ///
    /// - Complexity: O(1) constant time
    private func betterHashIndex(for key: Key) -> Int {
        var hasher = Hasher()
        hasher.combine(key)
        return abs(hasher.finalize()) % capacity
    }
}


// MARK: - Dynamic Resizing

extension HashTable {
    /// Checks whether the hash table should resize based on load factor
    ///
    /// Returns `true` when the load factor (size/capacity) exceeds the maximum threshold
    /// (0.75), indicating that collision chains are getting long and performance is degrading.
    ///
    /// - Returns: `true` if resizing is needed, `false` otherwise
    ///
    /// - Complexity: O(1) constant time
    private func shouldResize() -> Bool {
        return loadFactor > maxLoadFactor
    }

    /// Doubles the hash table capacity and rehashes all existing elements
    ///
    /// This method implements dynamic resizing to maintain O(1) average performance as the
    /// table grows. When called:
    /// 1. Saves reference to old buckets
    /// 2. Doubles capacity and creates new empty buckets array
    /// 3. Resets size counter (will be incremented during rehashing)
    /// 4. Iterates through all old buckets and their collision chains
    /// 5. Reinserts each key-value pair using new hash indices (based on new capacity)
    ///
    /// Rehashing is necessary because changing capacity changes the result of `hashIndex(for:)`,
    /// which uses `key.hashValue % capacity`. Elements must be redistributed to maintain
    /// correct lookup behavior.
    ///
    /// - Complexity: O(n) where n is the number of key-value pairs. Must visit and reinsert
    ///              every element in the table.
    private func resize() {
        let oldBuckets = buckets
        capacity *= 2
        size = 0
        buckets = Array(repeating: nil, count: capacity)

        // Rehash all existing elements
        for head in oldBuckets {
            var current = head
            while let node = current {
                insert(node.key, value: node.value)
                current = node.next
            }
        }
    }
}


// MARK: - Collision Resolution

extension HashTable {
    /// Inserts a key-value pair into a bucket, handling collisions via separate chaining
    ///
    /// This method implements collision resolution using separate chaining (linked lists).
    /// The algorithm handles three cases:
    ///
    /// **1. Empty bucket (no collision):**
    /// Creates a new HashNode and stores it directly at the bucket index. Returns `.success`.
    ///
    /// **2. Key already exists (update):**
    /// Traverses the collision chain looking for a node with matching key. If found, updates
    /// the existing node's value without changing size. Returns `.updated`.
    ///
    /// **3. Hash collision (new key hashes to occupied bucket):**
    /// Traverses to the end of the collision chain and appends a new node. Increments size.
    /// Returns `.collision` to indicate a collision occurred.
    ///
    /// - Parameters:
    ///   - key: The key to insert or update
    ///   - value: The value to associate with the key
    ///   - index: The bucket index (pre-computed via `hashIndex(for:)`)
    ///
    /// - Returns: A `HashTableResult` indicating what happened (success, collision, or update)
    ///
    /// - Complexity: O(1) for empty bucket or successful update. O(k) for collision where
    ///              k is the length of the collision chain (average k is small with good
    ///              load factor management).
    private func insertInChain(key: Key, value: Value, at index: Int) -> HashTableResult {
        if buckets[index] == nil {
            // No collision - direct insertion
            buckets[index] = HashNode(key: key, value: value)
            size += 1
            return .success
        }

        // Handle collision via chaining
        var current = buckets[index]
        while let node = current {
            if node.key == key {
                // Update existing key
                node.value = value
                return .updated
            }

            if node.next == nil {
                // Add to end of chain
                node.next = HashNode(key: key, value: value)
                size += 1
                return .collision
            }
            current = node.next
        }

        return .success
    }
}


// MARK: - CRUD Operations

extension HashTable {
    /// Inserts or updates a key-value pair, triggering resize if load factor is too high
    ///
    /// This method provides the complete insert operation:
    /// 1. Computes the bucket index for the key
    /// 2. Calls `insertInChain` to handle insertion/update/collision
    /// 3. Checks if resizing is needed (load factor > 0.75)
    /// 4. Resizes and rehashes if necessary
    ///
    /// If the key already exists, updates its value. If the key hashes to an occupied bucket,
    /// adds to the collision chain. Either way, maintains O(1) average performance through
    /// automatic resizing.
    ///
    /// - Parameters:
    ///   - key: The key to insert or update
    ///   - value: The value to associate with the key
    ///
    /// - Returns: A `HashTableResult` indicating the outcome (success, collision, or updated)
    ///
    /// - Complexity: O(1) average case. Worst case O(n) when resize triggers (amortized O(1)).
    @discardableResult
    public func insert(_ key: Key, value: Value) -> HashTableResult {
        let index = hashIndex(for: key)
        let result = insertInChain(key: key, value: value, at: index)

        // Resize if load factor is too high
        if shouldResize() {
            resize()
        }

        return result
    }

    /// Retrieves the value associated with a given key
    ///
    /// This method searches for the key by:
    /// 1. Computing its bucket index
    /// 2. Traversing the collision chain at that bucket
    /// 3. Comparing keys until a match is found or chain ends
    ///
    /// - Parameter key: The key to search for
    ///
    /// - Returns: The associated value if the key exists, or `nil` if not found
    ///
    /// - Complexity: O(1) average case. O(k) where k is the collision chain length
    ///              (typically very small with good load factor management).
    public func getValue(for key: Key) -> Value? {
        let index = hashIndex(for: key)
        var current = buckets[index]

        while let node = current {
            if node.key == key {
                return node.value
            }
            current = node.next
        }

        return nil
    }

    /// Removes a key-value pair from the hash table
    ///
    /// This method searches for and removes the key-value pair, handling two cases:
    ///
    /// **1. Key is first in bucket:**
    /// Updates the bucket to point to the second node (or nil if chain has only one node).
    ///
    /// **2. Key is later in collision chain:**
    /// Traverses the chain to find the node, then updates the previous node's `next` pointer
    /// to skip over the removed node.
    ///
    /// - Parameter key: The key to remove
    ///
    /// - Returns: The removed value if the key was found, or `nil` if not found
    ///
    /// - Complexity: O(1) average case. O(k) where k is the collision chain length.
    @discardableResult
    public func remove(_ key: Key) -> Value? {
        let index = hashIndex(for: key)

        guard let head = buckets[index] else {
            return nil
        }

        // Handle removal of first node
        if head.key == key {
            let removedValue = head.value
            buckets[index] = head.next
            size -= 1
            return removedValue
        }

        // Search through chain
        var current = head
        while let next = current.next {
            if next.key == key {
                let removedValue = next.value
                current.next = next.next
                size -= 1
                return removedValue
            }
            current = next
        }

        return nil
    }

    /// Checks whether a key exists in the hash table
    ///
    /// This is a convenience method that delegates to `getValue(for:)`. Returns `true`
    /// if the key exists (regardless of its value), `false` otherwise.
    ///
    /// - Parameter key: The key to check for existence
    ///
    /// - Returns: `true` if the key exists, `false` otherwise
    ///
    /// - Complexity: O(1) average case (delegates to `getValue(for:)`)
    public func contains(_ key: Key) -> Bool {
        return getValue(for: key) != nil
    }
}


// MARK: - Subscript Support

extension HashTable {
    /// Provides Dictionary-like subscript syntax for natural key-value access
    ///
    /// This subscript enables convenient syntax:
    /// ```swift
    /// let table = HashTable<String, Int>()
    /// table["count"] = 42          // Insert via setter
    /// let value = table["count"]   // Retrieve via getter (returns 42)
    /// table["count"] = nil         // Remove via setter with nil
    /// ```
    ///
    /// **Getter:** Returns the value for the key, or `nil` if not found (delegates to `getValue(for:)`)
    ///
    /// **Setter:** If newValue is non-nil, inserts/updates the key-value pair. If newValue is nil,
    /// removes the key (Dictionary-like behavior).
    ///
    /// - Parameter key: The key to access
    ///
    /// - Complexity: O(1) average case for both get and set operations
    public subscript(key: Key) -> Value? {
        get {
            return getValue(for: key)
        }
        set {
            if let value = newValue {
                insert(key, value: value)
            } else {
                remove(key)
            }
        }
    }
}
