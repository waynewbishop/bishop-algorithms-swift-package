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

/// A lightweight singly-linked node for stacks, queues, and hash table chaining
///
/// This class provides a minimal node implementation used across multiple data structures
/// in the package. Unlike `LLNode<T>` (doubly-linked with previous pointer) or `BSNode<T>`
/// (binary tree with left/right pointers), this node only tracks the next element in sequence.
///
/// **Key Features:**
/// - Singly-linked (only `next` pointer, no `previous`)
/// - Generic value storage via `tvalue`
/// - `Identifiable` conformance for SwiftUI integration
///
/// **Usage Examples:**
/// - **Stack**: Nodes form a singly-linked list with head as top of stack
/// - **Queue**: Nodes form a singly-linked list traversed from head to tail
/// - **Chain**: Used in `Chain<T>` for hash table collision resolution
///
/// **Identifiable Conformance:**
/// Each node has a unique `UUID` identifier, making nodes suitable as SwiftUI models
/// that require stable identity for list rendering and animations.
///
/// - Note: For doubly-linked lists, use `LLNode<T>`. For binary trees, use `BSNode<T>`.
public class Node<T> : Identifiable {

    /// Unique identifier for SwiftUI conformance to Identifiable
    ///
    /// Automatically generated UUID ensures each node has stable identity for use in
    /// SwiftUI views that require `Identifiable` models (like `ForEach`).
   public var id: UUID = UUID()

    /// The value stored in this node
    ///
    /// Generic value of type `T`. Can be nil for sentinel nodes or during initialization.
   public var tvalue: T?

    /// Reference to the next node in the sequence
    ///
    /// Points to the next node in a singly-linked structure, or nil if this is the last node.
   public var next: Node?

    /// Creates a new empty node with nil value and no next reference
    ///
    /// Initializes a node ready to be inserted into a data structure. The `id` is automatically
    /// generated. Value and next reference should be set after initialization.
    public init() {
        //package support
    }

}
