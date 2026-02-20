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

/// Extension on Array providing search and sorting algorithms for Comparable elements
///
/// This extension adds classic computer science algorithms to Swift arrays whose elements
/// conform to `Comparable`. Includes both searching algorithms (binary, linear) and multiple
/// sorting strategies (insertion, bubble, selection, quicksort).
///
/// **Educational Purpose:**
/// Each algorithm demonstrates different time complexities and trade-offs:
/// - **Search**: Binary O(log n) vs Linear O(n)
/// - **Basic sorts**: Insertion, Bubble, Selection all O(n²)
/// - **Advanced sort**: Quicksort O(n log n) average case
///
/// - Note: Constraint `where Element: Comparable` means these methods only exist on arrays
///         of comparable types like `[Int]`, `[String]`, etc.
extension Array where Element: Comparable {



    /// Returns the middle index of the array
    ///
    /// Computes the midpoint index used by binary search and divide-and-conquer algorithms.
    ///
    /// - Complexity: O(1) constant time
    var midIndex: Int {
      return startIndex + (count / 2)
    }


    //MARK: - Binary Search


    /// Searches for an element using binary search on a sorted array
    ///
    /// This method implements the recursive binary search algorithm, which repeatedly
    /// divides the search space in half. Binary search only works on sorted arrays.
    ///
    /// **Algorithm:**
    /// 1. Check if key is within array bounds (min/max)
    /// 2. Compare key with middle element
    /// 3. If key < middle: search left half (recursively)
    /// 4. If key > middle: search right half (recursively)
    /// 5. If key == middle: found!
    ///
    /// **Requirement:**
    /// Array MUST be sorted in ascending order for binary search to work correctly.
    ///
    /// - Parameter key: The element to search for
    ///
    /// - Returns: `true` if the element was found, `false` otherwise
    ///
    /// - Complexity: O(log n) logarithmic time - halves search space each iteration
    mutating func binarySearch(forElement key: Element) -> Bool {


        var result = false

        //establish indices
        let min = self.startIndex
        let max = self.endIndex - 1
        let mid = self.midIndex


        //check bounds
        if key > self[max] || key < self[min] {
            print("search value \(key) not found..")
            return false
        }


        //evaluate chosen number..
        let n = self[mid]


        print(String(describing: n) + "value attempted..")


        if n > key {
            var slice = Array(self[min...mid - 1])
            result = slice.binarySearch(forElement: key)
        }

        else if n < key {
            var slice = Array(self[mid + 1...max])
            result = slice.binarySearch(forElement: key)
        }

        else {
            print("search value \(key) found..")
            result = true
        }

        return result
    }



    //MARK: - Linear Search


    /// Searches for an element by checking every element sequentially
    ///
    /// This method implements linear search (also called sequential search), which examines
    /// each element in order until finding a match or reaching the end.
    ///
    /// **Algorithm:**
    /// Iterates through the array comparing each element to the key until finding a match.
    ///
    /// **Comparison with Binary Search:**
    /// - **Advantage**: Works on unsorted arrays
    /// - **Disadvantage**: Much slower than binary search for large sorted arrays
    ///
    /// - Parameter key: The element to search for
    ///
    /// - Returns: `true` if the element was found, `false` otherwise
    ///
    /// - Complexity: O(n) linear time - may need to check every element
    func linearSearch(forElement key: Element) -> Bool {

        //check all possible values
        for number in self {
            if number == key {
                return true
            }
        }

        return false

    }



    //MARK: - Insertion Sort


    /// Sorts the array using insertion sort algorithm
    ///
    /// This method implements insertion sort, which builds the sorted array one element at
    /// a time by inserting each element into its correct position within the sorted portion.
    ///
    /// **Algorithm:**
    /// 1. Consider first element as sorted (trivially true)
    /// 2. For each subsequent element (the "key"):
    ///    - Compare with sorted elements from right to left
    ///    - Shift sorted elements right to make space
    ///    - Insert key into correct position
    ///
    /// **Performance Characteristics:**
    /// - **Best case**: O(n) when array is already sorted
    /// - **Average/Worst case**: O(n²) due to nested comparisons and shifts
    /// - **Space**: O(n) for output array (not in-place)
    ///
    /// **When to Use:**
    /// - Small datasets (< 20 elements)
    /// - Nearly sorted data (approaches O(n) performance)
    /// - Online sorting (sorting data as it arrives)
    ///
    /// - Returns: A new sorted array in ascending order
    ///
    /// - Complexity: O(n²) average and worst case, O(n) best case for sorted input
    func insertionSort() -> Array<Element> {

        //check for trivial case
        guard self.count > 1 else {
            return self
        }

        var output: Array<Element> = self

        for primaryindex in 0..<output.count {

            let key = output[primaryindex]

            var secondaryindex = primaryindex

            while secondaryindex > -1 {
                print("comparing \(key) and \(output[secondaryindex])")
                if key < output[secondaryindex] {
                    //move into correct position
                    output.remove(at: secondaryindex + 1)
                    output.insert(key, at: secondaryindex)
                }
                secondaryindex -= 1
            }
        }

        return output
    }




    //MARK: - Bubble Sort


    /// Sorts the array using bubble sort algorithm
    ///
    /// This method implements bubble sort, which repeatedly steps through the array comparing
    /// adjacent elements and swapping them if they're in the wrong order. The largest element
    /// "bubbles up" to the end after each pass.
    ///
    /// **Algorithm:**
    /// 1. Compare each pair of adjacent elements
    /// 2. Swap them if they're out of order
    /// 3. Repeat for n passes (after pass i, last i elements are sorted)
    /// 4. Each pass reduces the comparison range by 1
    ///
    /// **Performance Characteristics:**
    /// - **Best case**: O(n) with early termination optimization (not implemented here)
    /// - **Average/Worst case**: O(n²) due to nested loops
    /// - **Space**: O(n) for output array
    ///
    /// **Observation:**
    /// After first pass, the largest element is in final position. After second pass, the
    /// two largest elements are in final positions. Hence the reducing range.
    ///
    /// - Returns: A new sorted array in ascending order
    ///
    /// - Complexity: O(n²) quadratic time for all cases (no optimizations)
    func bubbleSort() -> Array<Element> {


        //check for trivial case
        guard self.count > 1 else {
            return self
        }


        //mutated copy
        var output: Array<Element> = self


        for pindex in 0..<output.count {

            print("pindex: \(pindex)")

            let range = (output.count - 1) - pindex

            print("range: \(range)")

            //"half-open" range operator
            for sindex in 0..<range {

                print("sindex: \(sindex)")

                let key = output[sindex]

              //  print("comparing \(key) and \(output[sindex + 1])")

                //compare / swap positions
                if (key >= output[sindex + 1]) {
                    output.swapAt(sindex, sindex + 1)
                }
            }
        }

        return output

    }



    //MARK: - Selection Sort

    /// Sorts the array using selection sort algorithm
    ///
    /// This method implements selection sort, which repeatedly finds the minimum element
    /// from the unsorted portion and places it at the beginning of the unsorted region.
    ///
    /// **Algorithm:**
    /// 1. Find the minimum element in the unsorted portion
    /// 2. Swap it with the first unsorted element
    /// 3. Move boundary between sorted and unsorted portions one position right
    /// 4. Repeat until entire array is sorted
    ///
    /// **Performance Characteristics:**
    /// - **All cases**: O(n²) - performs same number of comparisons regardless of input
    /// - **Advantage**: Minimizes number of swaps (at most n swaps)
    /// - **Space**: O(n) for output array
    ///
    /// **Comparison with Insertion Sort:**
    /// - **Selection sort**: Always O(n²), minimal swaps
    /// - **Insertion sort**: O(n) best case for sorted data, more swaps
    ///
    /// - Returns: A new sorted array in ascending order
    ///
    /// - Complexity: O(n²) quadratic time for all cases
    func selectionSort() -> Array<Element> {


        //check for trivial case
        guard self.count > 1 else {
            return self
        }


        //mutated copy
        var output: Array<Element> = self


        for primaryindex in 0..<output.count {


            var minimum = primaryindex
            var secondaryindex = primaryindex + 1


            while secondaryindex < output.count {

                print("comparing \(output[minimum]) and \(output[secondaryindex])")

                // store lowest value as minimum
                if output[minimum] > output[secondaryindex] {
                    minimum = secondaryindex
                }

                secondaryindex += 1
            }


            // swap minimum value with array iteration
            if primaryindex != minimum {
                output.swapAt(primaryindex, minimum)
            }

        }


        return output

    }



    //MARK: - Quick Sort


    /// Sorts the array using quicksort algorithm (in-place, mutating)
    ///
    /// This method implements quicksort, a divide-and-conquer algorithm that selects a
    /// "pivot" element and partitions the array so elements less than the pivot come before
    /// it and elements greater come after.
    ///
    /// **Algorithm:**
    /// 1. Choose a pivot element (rightmost element in this implementation)
    /// 2. Partition: rearrange array so elements < pivot are left, elements > pivot are right
    /// 3. Recursively quicksort the left partition
    /// 4. Recursively quicksort the right partition
    ///
    /// **Partitioning (wall concept):**
    /// - Wall divides elements: left side ≤ pivot, right side > pivot
    /// - Scan through array comparing each element to pivot
    /// - If element ≤ pivot, swap it to the wall position and advance wall
    /// - Finally, swap pivot to wall position (its sorted location)
    ///
    /// **Performance Characteristics:**
    /// - **Best/Average case**: O(n log n) when partitions are balanced
    /// - **Worst case**: O(n²) when array is already sorted (poor pivot choices)
    /// - **Space**: O(log n) for recursion stack
    ///
    /// **This implementation:**
    /// - Sorts in-place (mutates self)
    /// - Uses rightmost element as pivot
    /// - No randomization (susceptible to O(n²) on sorted input)
    ///
    /// - Returns: The sorted array (self is mutated)
    ///
    /// - Complexity: O(n log n) average case, O(n²) worst case
    mutating func quickSort() -> Array<Element> {


        /// Recursive quicksort helper function
        ///
        /// Recursively sorts array partition from startIndex to pivot by partitioning
        /// and sorting the resulting left and right sub-partitions.
        ///
        /// - Parameters:
        ///   - startIndex: Beginning index of partition to sort
        ///   - pivot: Ending index of partition to sort
        func qSort(start startIndex: Int, _ pivot: Int) {

            if (startIndex < pivot) {
                let iPivot = qPartition(start: startIndex, pivot)
                qSort(start: startIndex, iPivot - 1)
                qSort(start: iPivot + 1, pivot)
            }
        }


        qSort(start: 0, self.endIndex - 1)
        return self

    }



    /// Partitions array segment around pivot element (quicksort helper)
    ///
    /// This method implements the partitioning step of quicksort using the "wall" technique.
    /// Rearranges elements so that all elements ≤ pivot are to the left of the wall, and
    /// all elements > pivot are to the right.
    ///
    /// **Wall Technique:**
    /// - **Wall index** tracks the boundary: left of wall = ≤ pivot, right of wall = > pivot
    /// - Scan through array comparing each element to pivot
    /// - If element ≤ pivot: swap to wall position, advance wall
    /// - If element > pivot: wall stays put, continue scanning
    /// - Finally: swap pivot to wall (its final sorted position)
    ///
    /// **Visualization:**
    /// ```
    /// [3, 7, 1, 9, 2, 5]  pivot=5, wall starts at 0
    ///  ^
    ///  wall
    ///
    /// After partitioning: [3, 1, 2, 5, 9, 7]
    ///                            ^
    ///                          pivot in final position
    /// ```
    ///
    /// - Parameters:
    ///   - startIndex: Beginning index of partition
    ///   - pivot: Index of pivot element (typically rightmost)
    ///
    /// - Returns: Final index of pivot element after partitioning
    ///
    /// - Complexity: O(n) where n is the partition size - single pass through elements
    mutating func qPartition(start startIndex: Int, _ pivot: Int) -> Int {

        var wallIndex: Int = startIndex


        //compare range with pivot
        for currentIndex in wallIndex..<pivot {

            print("current is: \(self[currentIndex]). pivot is \(self[pivot])")

            if self[currentIndex] <= self[pivot] {
                if wallIndex != currentIndex {
                    self.swapAt(currentIndex, wallIndex)
                }

                //advance wall
                wallIndex += 1
            }
        }


        //move pivot to final position
        if wallIndex != pivot {
            self.swapAt(wallIndex, pivot)
        }

        return wallIndex

    }



}
