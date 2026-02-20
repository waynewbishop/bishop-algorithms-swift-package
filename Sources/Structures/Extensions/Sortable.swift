//
//  Sortable.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/1/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// Extension on the Sortable protocol providing sorting validation functionality
///
/// This extension adds utility methods to any type conforming to the `Sortable` protocol.
/// Protocol extensions enable sharing common functionality across multiple conforming types
/// without requiring inheritance.
///
/// **Use Case:**
/// The `isSorted` method validates whether an array is correctly sorted, useful for:
/// - Testing sorting algorithm implementations
/// - Debugging sort correctness
/// - Pre-condition checking before binary search (requires sorted input)
///
/// - Note: This is an extension on a protocol, not a concrete type. Any class or struct
///         conforming to `Sortable` automatically gains this functionality.
extension Sortable {

    /// Validates whether an array is sorted in ascending order
    ///
    /// This method checks if the sequence satisfies the sorted invariant: every element
    /// must be ≤ the next element. Iterates through the array comparing adjacent pairs.
    ///
    /// **Algorithm:**
    /// Performs a single linear pass comparing `sequence[i]` with `sequence[i+1]`.
    /// Returns `false` immediately upon finding any out-of-order pair.
    ///
    /// **Common Use Cases:**
    /// - **Testing**: Verify sorting algorithms produce correct output
    /// - **Validation**: Check pre-conditions for binary search
    /// - **Debugging**: Identify where sorting logic fails
    ///
    /// - Parameter sequence: The array to validate
    ///
    /// - Returns: `true` if the array is sorted in ascending order (or empty/single element),
    ///           `false` if any adjacent pair is out of order
    ///
    /// - Complexity: O(n) where n is the array length - must compare all adjacent pairs
    func isSorted<T: Comparable>(_ sequence: Array<T>) -> Bool {

        //check trivial cases
        guard sequence.count >= 1 else {
            return true
        }

        var index = sequence.startIndex

        //compare sequence values - O(n)
        while index < sequence.endIndex - 1 {
            if sequence[index] > sequence[sequence.index(after: index)] {
                return false
            }
            index = sequence.index(after: index)
        }

        return true

    }

}
