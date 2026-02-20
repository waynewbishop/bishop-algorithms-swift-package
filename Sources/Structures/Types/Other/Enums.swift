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

/// Heap ordering constraint for priority queue implementations
///
/// The `HeapType` enum specifies whether a heap maintains min-heap or max-heap ordering.
/// This determines whether the root node contains the minimum or maximum element.
///
/// **Heap Properties:**
/// - **Min-heap**: Parent ≤ children (smallest element at root) - useful for priority queues
/// - **Max-heap**: Parent ≥ children (largest element at root) - useful for finding maximums
///
/// **Example Usage:**
/// ```swift
/// let minHeap = Heap<Int>(type: .min)  // Root is smallest
/// let maxHeap = Heap<Int>(type: .max)  // Root is largest
/// ```
///
/// - Note: Used by `Heap<T>` to configure heap ordering during initialization.
public enum HeapType {
    /// Min-heap: parent ≤ children, smallest element at root
    case min

    /// Max-heap: parent ≥ children, largest element at root
    case max
}
