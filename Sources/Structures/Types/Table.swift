//
//  Table.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 5/25/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A frequency-tracking wrapper class for priority queue implementations
///
/// This class wraps a value along with an occurrence count, enabling priority queues to
/// organize elements by frequency. It's used specifically by the `Priority<T>` class to
/// implement frequency-based priority queue operations.
///
/// **Use Case:**
/// When building a priority queue that prioritizes by frequency (most frequent item first),
/// each unique value is wrapped in a `Table<T>` that tracks how many times it occurs. The
/// priority queue can then use the `count` property to determine priority.
///
/// **Example:**
/// ```swift
/// let table = Table("apple", count: 1)
/// table.add("apple")  // count becomes 2
/// table.add("orange") // no change (different value)
/// ```
///
/// - Note: The `count` is only incremented when `add(_:)` receives a matching value,
///         allowing safe frequency tracking.
public class Table <T: Equatable> {

    /// The value being tracked for frequency
    ///
    /// Stores the unique value whose occurrences are being counted. Can be nil for
    /// empty/sentinel tables.
    var tvalue: T?

    /// The number of occurrences of this value
    ///
    /// Incremented each time `add(_:)` is called with a matching value. Used by priority
    /// queues to determine priority (higher count = higher priority).
    var count: Int

    /// Creates a new frequency tracker for the specified value
    ///
    /// Initializes a table with an initial count (defaults to 1 for first occurrence).
    ///
    /// - Parameters:
    ///   - tvalue: The value to track
    ///   - count: Initial occurrence count, defaults to 1
   public init(_ tvalue: T, count: Int = 1) {

        self.tvalue = tvalue
        self.count = count
    }

    /// Increments the count if the provided value matches this table's value
    ///
    /// This method safely increases the frequency count only when the provided value
    /// matches the stored `tvalue`. This ensures each Table tracks a single unique value.
    ///
    /// - Parameter tvalue: The value to compare and potentially count
    ///
    /// - Complexity: O(1) constant time—single equality check and increment
    public func add(_ tvalue: T) {

        if self.tvalue == tvalue {
            self.count += 1
        }
    }

}
