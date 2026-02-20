//
//  LLNode.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A generic node class for building doubly-linked lists
///
/// This class represents a single node in a doubly-linked list data structure. Each node
/// contains a value and optional references to both the next and previous nodes in the sequence.
/// The doubly-linked structure enables efficient traversal in both directions and O(1) insertion
/// and deletion operations when you have a reference to the node.
///
/// This node type is used by `LinkedList` to build dynamic sequences that can grow and shrink
/// efficiently without array reallocation costs.
///
/// - Note: This is a doubly-linked node. For singly-linked lists (hash table chaining),
///         see `Chain` which only maintains a `next` reference.
public class LLNode<T> {

    /// The value stored in this node
    var tvalue: T?

    /// Reference to the next node in the sequence
    ///
    /// Points to the following node in the linked list, or `nil` if this is the tail node.
    var next: LLNode?

    /// Reference to the previous node in the sequence
    ///
    /// Points to the preceding node in the linked list, or `nil` if this is the head node.
    /// This backward link enables O(1) deletion and bidirectional traversal.
    var previous: LLNode?

    /// Creates a new empty linked list node
    ///
    /// Initializes a node with no value and no connections. The value and links should be
    /// set separately when the node is inserted into a list.
    public init() {
        // Empty initialization for playground and testing support
    }
}
