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

/// A generic stack implementation using a singly-linked list
///
/// This class provides a Last-In-First-Out (LIFO) data structure where elements are added
/// and removed from the same end (the "top"). Stacks are fundamental to many algorithms
/// including depth-first search, expression evaluation, undo mechanisms, and function call
/// management in programming language runtimes.
///
/// All core operations (`push`, `pop`, `peek`) execute in constant O(1) time by maintaining
/// a reference to the top node. The stack grows dynamically without requiring array reallocation,
/// making it memory-efficient for unpredictable workloads.
///
/// This implementation conforms to `Sequence` and `IteratorProtocol`, enabling Swift's
/// for-in loop syntax and functional programming operations like `map` and `filter`.
///
/// - Note: This class uses `Node<T>` for storage (singly-linked list). For FIFO behavior
///         (First-In-First-Out), see `Queue`.
public class Stack <T> : Sequence, IteratorProtocol {

    /// Reference to the top node in the stack
    ///
    /// The top node contains the most recently pushed value. All stack operations
    /// (push, pop, peek) access this reference first.
   public var top: Node<T>

   /// Count of elements currently in the stack
   ///
   /// Maintained incrementally during push/pop operations to provide O(1) count access
   /// without traversing the entire stack.
   private var counter: Int = 0

   /// Internal iterator reference for Sequence protocol conformance
   ///
   /// Tracks the current position during iteration through the stack elements.
   private var iterator: Node<T>?

   /// Internal iteration counter for resetting iterator state
   ///
   /// Tracks how many times `next()` has been called to manage iterator lifecycle.
   private var times: Int = 0

    /// Creates a new empty stack
    ///
    /// Initializes a stack with an empty top node ready to accept the first pushed value.
  public init() {
        top = Node<T>()
    }

    /// Returns all nodes in the stack as an array
    ///
    /// This property traverses the entire stack from top to bottom, collecting all nodes
    /// into an array. The order matches the stack structure: index 0 is the top (most recent),
    /// and the last index is the bottom (oldest element).
    ///
    /// - Complexity: O(n) where n is the number of elements in the stack
    ///
    /// - Returns: An array of all `Node<T>` instances in the stack
    public var values: Array<Node<T>> {

        var results = Array<Node<T>>()

        var current: Node<T>? = top

        while let item = current {
            results.append(item)
            current = item.next
        }

        return results

    }

    /// The number of elements currently in the stack
    ///
    /// This computed property returns the cached counter value, providing O(1) constant-time
    /// access to the stack size without needing to traverse the structure.
    ///
    /// - Complexity: O(1)
  public  var count: Int {
        return counter
    }
    
    //MARK: Other functions

    /// Returns the top element without removing it from the stack
    ///
    /// This method provides read-only access to the most recently pushed value.
    /// The stack structure remains unchanged—use `pop()` or `popValue()` to remove
    /// the top element.
    ///
    /// - Returns: The value at the top of the stack, or `nil` if the stack is empty
    ///
    /// - Complexity: O(1) constant time—accesses only the top node reference
    public func peek() -> T? {

        if let item = top.tvalue {
            return item
        }
        else {
            return nil
        }
    }

    /// Checks whether the stack contains any elements
    ///
    /// This method provides a semantic way to test for emptiness. Equivalent to
    /// checking `count == 0`, but more readable and explicit about intent.
    ///
    /// - Returns: `true` if the stack contains zero elements, `false` otherwise
    ///
    /// - Complexity: O(1) constant time—checks only the cached counter
    public func isEmpty() -> Bool {

        if self.count == 0 {
            return true
        }

        else {
            return false
        }

    }
    /// Adds a new value to the top of the stack
    ///
    /// This method implements the fundamental stack operation of pushing an element onto
    /// the top. The new value becomes immediately accessible via `peek()` and will be the
    /// first element returned by `pop()`.
    ///
    /// The implementation creates a new node containing the value and links it as the new
    /// top, pushing the previous top down in the stack. This preserves LIFO order: the
    /// most recently pushed value is always the first to be popped.
    ///
    /// - Parameter tvalue: The value to add to the top of the stack
    ///
    /// - Complexity: O(1) constant time—only updates the top reference and counter
  public func push(_ tvalue: T) {


        //return trivial case
        guard top.tvalue != nil else {
            top.tvalue = tvalue
            counter += 1
            return
        }


        //create new item
        let childToUse = Node<T>()
        childToUse.tvalue = tvalue


        //set new created item at top
        childToUse.next = top
        top = childToUse


        //set counter
        counter += 1

    }

//MARK: Iterator protocol conformance

    /// Returns the next element in the iteration sequence
    ///
    /// This method implements the `IteratorProtocol` requirement, enabling Swift's for-in
    /// loop syntax and functional operations. The iterator traverses from top to bottom,
    /// returning values in LIFO order (same order as repeated `pop()` calls).
    ///
    /// The iterator state is managed internally via `iterator` and `times` properties.
    /// After exhausting all elements, the iterator automatically resets for potential reuse.
    ///
    /// - Returns: The next value in the stack, or `nil` when iteration completes
    ///
    /// - Complexity: O(1) per call—advances to the next node via single pointer traversal
    public func next() -> T? {

        print("iterator called..")

        //check starting reference
        if times == 0 {
            iterator = top
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


//MARK: Pop functions

    /// Removes and returns the top element from the stack
    ///
    /// This method implements the fundamental stack operation of popping, which removes
    /// the most recently pushed value and returns it to the caller. The previous element
    /// (if any) becomes the new top of the stack.
    ///
    /// If the stack is empty, this method returns `nil` without modifying the structure.
    /// This is the preferred pop method when you need the removed value.
    ///
    /// - Returns: The value that was at the top of the stack, or `nil` if empty
    ///
    /// - Complexity: O(1) constant time—updates only the top reference and counter
    public func popValue() ->T? {

        guard let results = top.tvalue else {
            return nil
        }


        //make reassignment
        if let element = top.next {
            top = element
            counter -= 1
        }

        else {
            top.tvalue = nil
            counter = 0
        }

        return results

    }

    /// Removes the top element from the stack without returning it
    ///
    /// This method provides a void-returning alternative to `popValue()` for cases where
    /// the removed value is not needed. Useful when you only need to discard the top element.
    ///
    /// If the stack is empty, this method safely handles the case without error, resetting
    /// the counter to maintain consistency.
    ///
    /// - Complexity: O(1) constant time—updates only the top reference and counter
    public func pop() {

        if top.tvalue == nil {
            counter = 0
        }

        //make reassignment
        if let element = top.next {
            top = element
            counter -= 1
        }

        else {
            top.tvalue = nil
            counter = 0
        }

    }
    
    


}
