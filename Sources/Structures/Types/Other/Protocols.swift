//
//  Protocols.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/1/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// Protocol defining hash computation for custom hash table implementations
///
/// The `Indexable` protocol extends `Hashable` to add an ASCII-based hash computation
/// requirement. This enables custom types to work with the package's educational hash
/// table implementations (`HashSet` and `HashChain`).
///
/// **Purpose:**
/// This protocol bridges Swift's built-in `Hashable` protocol with custom hash table
/// implementations that use ASCII representation for hashing. While production code
/// should use Swift's standard `Hashable`, this protocol demonstrates hash function
/// concepts for educational purposes.
///
/// **Conforming Types:**
/// - `String`: Sums Unicode scalar values of all characters
/// - `Int`: Sums Unicode values of digit characters
///
/// **Example:**
/// ```swift
/// extension String: Indexable {
///     public var asciiRepresentation: Int {
///         var sum = 0
///         for char in self.unicodeScalars {
///             sum += Int(char.value)
///         }
///         return sum
///     }
/// }
/// ```
///
/// - Note: This is an educational protocol. Production code should use Swift's built-in
///         `Hashable` protocol with `Dictionary` or `Set`.
public protocol Indexable: Hashable {

    /// Computes an integer hash value from the type's content
    ///
    /// Implementations should convert the value to an integer representation suitable
    /// for hash table indexing. The most common approach is summing Unicode scalar values.
    ///
    /// - Returns: Integer hash value derived from the type's content
    var asciiRepresentation: Int {get}
}


/// Protocol defining sort validation for comparable collections
///
/// The `Sortable` protocol provides a standard interface for validating whether arrays
/// are correctly sorted in ascending order. This is useful for testing sorting algorithm
/// implementations and verifying pre-conditions for algorithms that require sorted input
/// (like binary search).
///
/// **Purpose:**
/// - Testing: Verify sorting algorithms produce correct output
/// - Validation: Check pre-conditions before binary search or other sorted-input algorithms
/// - Debugging: Identify where sorting logic fails
///
/// **Usage Example:**
/// ```swift
/// class SortingAlgorithms: Sortable {
///     func bubbleSort(_ array: [Int]) -> [Int] {
///         // ...sorting implementation
///         let sorted = /* sorted result */
///         assert(isSorted(sorted), "Bubble sort failed to sort correctly")
///         return sorted
///     }
/// }
/// ```
///
/// - Note: The protocol extension in `Sortable.swift` provides a default implementation
///         that performs O(n) linear validation by comparing adjacent pairs.
public protocol Sortable {

    /// Validates whether an array is sorted in ascending order
    ///
    /// Checks if the sequence satisfies the sorted invariant: every element must be ≤
    /// the next element. The default implementation (provided via protocol extension)
    /// performs a single linear pass comparing adjacent pairs.
    ///
    /// - Parameter sequence: The array to validate
    ///
    /// - Returns: `true` if sorted in ascending order (or empty/single element),
    ///           `false` if any adjacent pair is out of order
    ///
    /// - Complexity: O(n) where n is the array length - must compare all adjacent pairs
    func isSorted<T: Comparable>(_ sequence: Array<T>) -> Bool
}
