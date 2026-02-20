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

/// A lightweight array-backed stack implementation
///
/// This struct provides a simple Last-In-First-Out (LIFO) data structure using Swift's
/// native `Array` as the underlying storage. Unlike the node-based `Stack` class, this
/// implementation leverages array operations for maximum simplicity and performance.
///
/// All stack operations (`push`, `pop`, `peek`) execute in O(1) amortized constant time
/// thanks to Swift's array implementation. The struct is a value type, meaning it exhibits
/// copy-on-write semantics and can be safely passed around without reference management concerns.
///
/// This is the preferred stack implementation for most use cases due to:
/// - Simpler implementation (no node allocation overhead)
/// - Better cache locality (contiguous memory)
/// - Native Swift collection features (Array methods, Sequence conformance)
///
/// - Note: For linked-list-based stack with iterator support, see `Stack` class.
public struct SimpleStack <T> {

       /// The array storing stack elements
       ///
       /// Elements are stored in order from bottom (index 0) to top (last index).
       /// The most recently pushed value is always at `elements.last`.
       var elements : [T] = [T]()

        /// Creates a new empty stack
        ///
        /// Initializes an empty stack ready to accept pushed elements.
        public init() {
            //playground support
        }

        /// The number of elements currently in the stack
        ///
        /// This computed property returns the array count, providing O(1) access to stack size.
        ///
        /// - Complexity: O(1)
        var count: Int {
            return elements.count
        }

        /// Returns the top element without removing it from the stack
        ///
        /// This method provides read-only access to the most recently pushed value.
        /// The stack structure remains unchanged—use `pop()` to remove the top element.
        ///
        /// - Returns: The value at the top of the stack, or `nil` if the stack is empty
        ///
        /// - Complexity: O(1) constant time—accesses only the last array element
        public func peek() -> T? {
              return elements.last
          }

        /// Adds a new value to the top of the stack
        ///
        /// This method implements the fundamental stack operation of pushing an element onto
        /// the top. The new value becomes immediately accessible via `peek()` and will be the
        /// first element returned by `pop()`.
        ///
        /// - Parameter element: The value to add to the top of the stack
        ///
        /// - Complexity: O(1) amortized constant time—array append is O(1) amortized
        public mutating func push(_ element: T) {
              elements.append(element)
          }

        /// Removes and returns the top element from the stack
        ///
        /// This method implements the fundamental stack operation of popping, which removes
        /// the most recently pushed value and returns it to the caller.
        ///
        /// - Returns: The value that was at the top of the stack, or `nil` if empty
        ///
        /// - Complexity: O(1) constant time—array popLast is O(1)
        public mutating func pop() -> T? {
              return elements.popLast()
          }

        /// Swaps two elements at specified indices in the stack
        ///
        /// This method exchanges the positions of two elements without removing them from
        /// the stack. Useful for in-place algorithms that need to reorder stack contents.
        ///
        /// - Parameters:
        ///   - lhs: The index of the first element to swap
        ///   - rhs: The index of the second element to swap
        ///
        /// - Complexity: O(1) constant time—array swapAt is O(1)
        public mutating func swapAt(lhs: Int, rhs: Int) -> () {
            self.elements.swapAt(lhs, rhs)
        }

    }

