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

/// A frequency-based priority queue that organizes elements by occurrence count
///
/// This class maintains a collection of elements sorted by frequency using a max-heap structure.
/// When you add values, the priority queue tracks how many times each unique value appears and
/// automatically maintains heap order so the most frequent element is always at the top.
///
/// This is useful for:
/// - Frequency analysis and counting problems
/// - Finding the most common elements in a stream
/// - Huffman encoding (where frequencies determine tree structure)
/// - Top-K frequent elements problems
///
/// The implementation uses a `Table<T>` wrapper to store both the value and its count,
/// organized in an array-based max-heap. Each add operation performs bottom-up heapification
/// to maintain the heap property: parent counts are always ≥ child counts.
///
/// - Note: Unlike standard priority queues that accept external priorities, this queue
///         automatically derives priority from occurrence count.
public class Priority <T: Equatable> {

    /// Array of frequency tables organized as a max-heap
    ///
    /// Each `Table<T>` stores a unique value and its occurrence count. The array maintains
    /// heap order: items[i].count ≥ items[2i+1].count and items[i].count ≥ items[2i+2].count
    private var items: Array<Table<T>> = [Table<T>]()

    /// Creates a new empty priority queue
    ///
    /// Initializes an empty priority queue ready to accept elements and track their frequencies.
    public init() {
        //package support
    }
    /// Returns all frequency tables in heap order
    ///
    /// This method provides access to the internal heap structure for inspection or iteration.
    /// The returned array is in heap order (not sorted by frequency), with the most frequent
    /// element at index 0.
    ///
    /// - Returns: An array of `Table<T>` objects containing values and their counts,
    ///           or `nil` if the queue is empty
    ///
    /// - Complexity: O(1) constant time—returns reference to internal array
    public func get() -> Array<Table<T>>? {

        if items.count > 0 {
            return items
        }
        else {
            return nil
        }
    }

    /// Adds a value to the priority queue and maintains heap order
    ///
    /// This method performs two operations:
    /// 1. **Frequency tracking**: If the value already exists, increments its count.
    ///    Otherwise, creates a new `Table<T>` entry with count = 1.
    /// 2. **Heapification**: Performs bottom-up heapification to restore heap property,
    ///    bubbling the added/updated element up until parent count ≥ child count.
    ///
    /// The heapification uses the standard bottom-up approach: compare the child with its
    /// parent (at index `floor((childIndex - 1) / 2)`) and swap if the child count is greater,
    /// then repeat until reaching the root or finding correct position.
    ///
    /// - Parameter tvalue: The value to add to the priority queue
    ///
    /// - Complexity: O(n + log n) where n is the number of unique values. The linear scan
    ///              to find existing values could be optimized to O(1) with a dictionary,
    ///              reducing overall complexity to O(log n) for heapification only.
    public func add(_ tvalue: T) {
        
        var isAdded: Bool = false
        
        var parentIndex: Int = 0
        var addedIndex: Float = -1
        var childIndex: Float = 0
        
        
        //dp - check for existing values
        
        for s in items {
            addedIndex += 1
        
            if s.tvalue == tvalue {
                s.count += 1
                isAdded = true
                childIndex = addedIndex
                break
            }
        }
        
        
        if isAdded == false {
            let table: Table = Table(tvalue)
            items.append(table)
            
            //update index
            childIndex = Float(items.count) - 1
        }
                
        
        //heapify - bottom-up approach O(log n)
                  
          
          //calculate parent index
          if  childIndex != 0 {
              parentIndex = Int(floorf((childIndex - 1) / 2))
          }
          
          
          var childToUse: Table<T>
          var parentToUse: Table<T>
          
              
          //use the bottom-up approach
          while childIndex != 0 {
              
              
              childToUse = items[Int(childIndex)]
              parentToUse = items[parentIndex]
              
                  
              //swap child and parent positions
              if childToUse.count > parentToUse.count {
                  items.swapAt(parentIndex, Int(childIndex))
              }
              else {
                break
              }
              
              
              //reset indices
              childIndex = Float(parentIndex)
              
              
              if childIndex != 0 {
                  parentIndex = Int(floorf((childIndex - 1) / 2))
              }
              
              
          } //end while
        
        
    } //end function
         
        
}
