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

/// Extension on Int providing custom protocol conformance and algorithmic utilities
///
/// This extension adds hash table support plus various integer-based algorithms, particularly
/// focusing on Fibonacci sequence generation using different algorithmic approaches.
///
/// **Key Features:**
/// - **Hash table integration**: ASCII representation for custom hash functions
/// - **Fibonacci variants**: Iterative, recursive, closure-based, and memoized implementations
/// - **Utility methods**: Even/odd checking, iteration helpers
extension Int: Indexable {


    /// Determines whether the integer is even
    ///
    /// Checks if the number is divisible by 2 using the modulo operator.
    ///
    /// - Returns: `true` if the number is even, `false` if odd
    ///
    /// - Complexity: O(1) constant time
    public func isEven() -> Bool {
        return (self % 2 == 0 ? true : false)
    }

    /// Computes an integer hash value by summing digit Unicode values
    ///
    /// Required by the `Indexable` protocol for use with `HashSet` and `HashChain`.
    /// Converts the integer to a string, then sums the Unicode values of each digit character.
    ///
    /// This enables integers to be stored in custom hash tables that require the `Indexable`
    /// protocol (for educational purposes). Production code should use Swift's built-in
    /// `Hashable` protocol instead.
    ///
    /// - Returns: Sum of Unicode scalar values for all digits
    ///
    /// - Complexity: O(d) where d is the number of digits
    public var asciiRepresentation: Int {
           var divisor: Int = 0

           for item in String(self).unicodeScalars {
               divisor += Int(item.value)
           }

           return divisor
       }



    /// Executes a closure body n times with the iteration index
    ///
    /// This method provides Ruby-style iteration: `5.times { print($0) }` prints 0,1,2,3,4,5.
    /// The closure receives the current iteration index from 0 to n.
    ///
    /// - Parameter closure: Closure to execute, receives iteration index as parameter
    ///
    /// - Complexity: O(n) - executes closure n+1 times (0...self inclusive)
    func times(closure:(Int)-> Void) {
        for i in 0...self {
            closure(i)
        }
    }



    /// Generates Fibonacci sequence up to position n using iterative approach
    ///
    /// This method implements the classic iterative Fibonacci algorithm by building the
    /// sequence element-by-element from the base case [0, 1].
    ///
    /// **Algorithm:**
    /// 1. Starts with base sequence [0, 1]
    /// 2. Each iteration computes: F(n) = F(n-1) + F(n-2)
    /// 3. Appends result and continues until reaching position n
    ///
    /// **Example:**
    /// ```
    /// 5.fibNormal() // Returns [0, 1, 1, 2, 3]
    /// ```
    ///
    /// - Returns: Array containing Fibonacci sequence from position 0 to n-1, or `nil` if n ≤ 2
    ///
    /// - Complexity: O(n) time to build sequence, O(n) space for array storage
    func fibNormal() -> Array<Int>? {


        //check trivial condition
        guard self > 2 else {
            return nil
        }


        //initialize the sequence
        var sequence: Array<Int> = [0, 1]


        var i: Int = sequence.count

        while i != self {

            let results: Int = sequence[i - 1] + sequence[i - 2]
            sequence.append(results)

            i += 1
        }


        return sequence

    }


    /// Generates Fibonacci sequence recursively using mutable self parameter
    ///
    /// This method demonstrates recursive Fibonacci generation where the sequence is built
    /// by recursive calls that each extend the array by one element.
    ///
    /// **Algorithm:**
    /// - **Base case**: When sequence length == n, return the sequence
    /// - **Recursive case**: Compute next Fibonacci number, append, recurse with longer array
    ///
    /// **Note:**
    /// Uses `mutating` to modify self during recursion. Less efficient than iterative approach
    /// due to recursion overhead and repeated array copying.
    ///
    /// - Parameter sequence: Initial sequence (defaults to [0, 1])
    ///
    /// - Returns: Array containing Fibonacci sequence from position 0 to n-1, or `nil` if n ≤ 2
    ///
    /// - Complexity: O(n) time for n recursive calls, O(n²) space due to array copying at each level
    mutating func fibRecursive(_ sequence: Array<Int> = [0, 1]) -> Array<Int>? {


        var final = Array<Int>()


        //mutated copy
        var output = sequence


        //check trivial condition
        guard self > 2 else {
            return nil
        }


        let i: Int = output.count


        //set base condition
        if i == self {
            return output
        }



        let results: Int = output[i - 1] + output[i - 2]
        output.append(results)


        //set iteration
        if let recursiveResult = self.fibRecursive(output) {
            final = recursiveResult
        }


        return final

    }



    /// Generates Fibonacci sequence using a custom formula closure
    ///
    /// This method demonstrates functional programming by accepting a closure that defines
    /// how to compute the next Fibonacci number from the sequence. This makes the algorithm
    /// flexible - the formula can be customized without changing the iteration logic.
    ///
    /// **Example:**
    /// ```
    /// let fib = 5.fibClosure { sequence in
    ///     return sequence[sequence.count - 1] + sequence[sequence.count - 2]
    /// }
    /// ```
    ///
    /// - Parameter formula: Closure that receives the current sequence and returns the next value
    ///
    /// - Returns: Array containing Fibonacci sequence from position 0 to n-1, or `nil` if n ≤ 2
    ///
    /// - Complexity: O(n) time, O(n) space
    func fibClosure(withFormula formula: (Array<Int>) -> Int) -> Array<Int>? {


        //check trivial condition
        guard self > 2 else {
            return nil
        }


        //initialize the sequence
        var sequence: Array<Int> = [0, 1]

        var i: Int = sequence.count

        while i != self {

            let results: Int = formula(sequence)
            sequence.append(results)

            i += 1
        }


        return sequence


    } //end function


    /// Computes the nth Fibonacci number using memoization (dynamic programming)
    ///
    /// This method demonstrates dynamic programming optimization. Unlike the recursive approach
    /// which recomputes values, this builds the sequence once and retrieves the final answer
    /// in constant time.
    ///
    /// **Algorithm:**
    /// 1. **Nested function** `fibSequence` builds the complete Fibonacci array recursively
    /// 2. **Memoization**: The array stores all intermediate results (subproblem solutions)
    /// 3. **Final calculation**: Sum last two elements to get the nth Fibonacci number
    ///
    /// **Performance:**
    /// - Building sequence: O(n) - linear time, only computed once
    /// - Final answer: O(1) - constant time lookup and addition
    ///
    /// This is the most efficient approach shown, avoiding redundant calculations entirely.
    ///
    /// - Returns: The nth Fibonacci number (not the full sequence)
    ///
    /// - Complexity: O(n) time to build sequence, O(1) to retrieve answer. O(n) space for memoization array.
     func fibMemoized() -> Int {


        /// Recursively builds the complete Fibonacci sequence up to position n
        ///
        /// This nested function constructs the memoization array by recursively extending
        /// the sequence one element at a time until reaching the target position.
        ///
        /// - Parameter sequence: Current sequence being built (defaults to [0, 1])
        ///
        /// - Returns: Complete Fibonacci sequence from 0 to n
        func fibSequence(_ sequence: Array<Int> = [0, 1]) -> Array<Int> {

            print("fibSequence called..")

            var final = Array<Int>()


            //mutated copy
            var output = sequence


            let i: Int = output.count


            //set base condition - linear time O(n)
            if i == self {
                return output
            }


            let results: Int = output[i - 1] + output[i - 2]
            output.append(results)


            //set iteration
            final = fibSequence(output)

            return final


        } //end function



        //calculate final product - constant time O(1)
        let results = fibSequence()
        let answer: Int = results[results.endIndex - 1] + results[results.endIndex - 2]
        return answer

    }


}
