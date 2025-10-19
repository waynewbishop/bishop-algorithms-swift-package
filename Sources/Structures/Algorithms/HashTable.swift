//
//  HashTable.swift
//  SwiftStructures
//
//  Created by Wayne Bishop
//  Copyright © 2025 Arbutus Software Inc. All rights reserved.
//

import Foundation


/**
 Production-ready hash table implementation with key-value pairs, dynamic resizing, and collision handling.

 This is the **most advanced** hash table in the package, demonstrating:
 - Key-value pair storage (dictionary-like)
 - Dynamic resizing with load factor management
 - Collision resolution via separate chaining
 - Full CRUD operations
 - Subscript support for natural Swift syntax

 For simpler implementations:
 - `HashSet`: Basic hash table without collision handling
 - `HashChain`: Intermediate with collision handling (set-like)

 - Complexity: Average O(1) for insert, search, delete. Worst-case O(n) when all keys hash to same bucket.
 - Important: Uses Swift's built-in Hashable protocol for maximum compatibility
 - Corresponds to: Chapter 15 of Swift Algorithms & Data Structures book
 */

// MARK: - Supporting Types

/// Generic node for collision resolution via chaining (linked list)
public class HashNode<Key: Hashable, Value> {
    public let key: Key
    public var value: Value
    public var next: HashNode<Key, Value>?

    public init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}


/// Result types for hash table operations
public enum HashTableResult {
    case success
    case collision
    case notFound
    case updated
}


// MARK: - Hash Table Implementation

/// Hash table with dynamic resizing and load factor management - O(1) average operations
public class HashTable<Key: Hashable, Value> {
    private var buckets: [HashNode<Key, Value>?]
    private var capacity: Int
    private var size: Int = 0

    // Load factor threshold for resizing
    private let maxLoadFactor: Double = 0.75

    public init(capacity: Int = 16) {
        self.capacity = capacity
        self.buckets = Array(repeating: nil, count: capacity)
    }

    public var count: Int {
        return size
    }

    public var isEmpty: Bool {
        return size == 0
    }

    // Current load factor for performance monitoring
    public var loadFactor: Double {
        return Double(size) / Double(capacity)
    }
}


// MARK: - Hash Functions

extension HashTable {
    /// Modern hash function using Swift's built-in hasher
    private func hashIndex(for key: Key) -> Int {
        return abs(key.hashValue) % capacity
    }

    /// Alternative hash function for better distribution
    private func betterHashIndex(for key: Key) -> Int {
        var hasher = Hasher()
        hasher.combine(key)
        return abs(hasher.finalize()) % capacity
    }
}


// MARK: - Dynamic Resizing

extension HashTable {
    private func shouldResize() -> Bool {
        return loadFactor > maxLoadFactor
    }

    /// Resize and rehash all elements when load factor exceeds threshold - O(n)
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
    /// Handle collisions by chaining nodes in linked list - O(1) insertion, O(k) search where k=chain length
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
    /// Insert or update a key-value pair
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

    /// Retrieve value for a given key
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

    /// Remove a key-value pair
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

    /// Check if key exists
    public func contains(_ key: Key) -> Bool {
        return getValue(for: key) != nil
    }
}


// MARK: - Subscript Support

extension HashTable {
    /// Subscript support for Dictionary-like syntax - O(1) average
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
