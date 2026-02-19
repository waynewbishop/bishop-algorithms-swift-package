//
//  BSNode.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 9/16/17.
//  Copyright © 2017 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A generic node class for building binary search trees (BSTs)
///
/// This class represents a node in a binary search tree data structure. Each node contains
/// a value and optional references to left and right child nodes. The tree maintains the
/// BST property: all values in the left subtree are less than the node's value, and all
/// values in the right subtree are greater than the node's value.
///
/// The node also tracks its height in the tree, which is used by balanced tree implementations
/// like AVL trees to maintain O(log n) performance guarantees.
///
/// - Note: This class is typically used in conjunction with `BSModel` which provides
///         tree management operations like insertion, deletion, and automatic balancing.
public class BSNode<T> {

    /// The value stored in this node
    var tvalue: T?

    /// Reference to the left child node (values less than this node's value)
    var left: BSNode?

    /// Reference to the right child node (values greater than this node's value)
    var right: BSNode?

    /// The height of this node in the tree (distance from deepest leaf)
    ///
    /// Height is used for balancing operations in AVL trees. A leaf node has height 0,
    /// and each parent's height is 1 + max(left.height, right.height).
    var height: Int

    /// Creates a new BSNode with default values
    ///
    /// Initializes a node with no value and height of 0. The value should be set
    /// separately when the node is inserted into a tree.
    public init() {
        self.height = 0
    }

    /// Returns the total number of nodes in the subtree rooted at this node
    ///
    /// This computed property recursively counts all nodes in the left and right subtrees,
    /// plus the current node. Useful for determining tree size without maintaining a
    /// separate counter.
    ///
    /// - Complexity: O(n) where n is the number of nodes in the subtree
    var count: Int {
        var leftCount = 0
        var rightCount = 0

        if let left = self.left {
            leftCount = left.count
        }

        if let right = self.right {
            rightCount = right.count
        }

        return leftCount + 1 + rightCount
    }

    // MARK: - Tree Navigation

    /// Returns the minimum value in the subtree rooted at this node
    ///
    /// Finds the minimum value by following the left child pointers until reaching
    /// a node with no left child. In a valid BST, this is always the leftmost node.
    ///
    /// - Returns: The minimum value in the subtree, or nil if the node has no value
    /// - Complexity: O(log n) for balanced trees, O(n) for unbalanced trees
    public func minimum() -> T? {
        if let left = left {
            return left.minimum()
        }
        return tvalue
    }

    /// Returns the maximum value in the subtree rooted at this node
    ///
    /// Finds the maximum value by following the right child pointers until reaching
    /// a node with no right child. In a valid BST, this is always the rightmost node.
    ///
    /// - Returns: The maximum value in the subtree, or nil if the node has no value
    /// - Complexity: O(log n) for balanced trees, O(n) for unbalanced trees
    public func maximum() -> T? {
        if let right = right {
            return right.maximum()
        }
        return tvalue
    }

    // MARK: - Traversal Algorithms

    /// Performs a breadth-first search (BFS) traversal of the tree
    ///
    /// BFS visits nodes level by level, from left to right. This traversal uses a queue
    /// to maintain the order of nodes to visit. It's useful for finding the shortest path
    /// to a node or processing nodes by distance from the root.
    ///
    /// The traversal prints each node's value as it's visited, followed by a completion message.
    ///
    /// - Complexity: O(n) time where n is the number of nodes, O(w) space where w is the
    ///              maximum width of the tree (number of nodes at the widest level)
    public func BFSTraverse() -> () {

        let bsQueue = Queue<BSNode<T>>()

        // Queue the starting node
        bsQueue.enQueue(self)

        while bsQueue.peek() != nil {

            // Traverse the next queued node
            if let bitem = bsQueue.deQueue() {

                if let key = bitem.tvalue {
                    print("now traversing item: \(key)")
                }

                // Queue left descendant
                if let left = bitem.left {
                    bsQueue.enQueue(left)
                }

                // Queue right descendant
                if let right = bitem.right {
                    bsQueue.enQueue(right)
                }
            }
        }

        print("bfs traversal complete..")
    }

    /// Performs a depth-first search (DFS) in-order traversal of the tree
    ///
    /// DFS in-order traversal visits nodes in sorted order for a BST: left subtree,
    /// current node, right subtree. This recursive approach naturally follows the
    /// tree structure and produces values in ascending order.
    ///
    /// The traversal prints each node's value and height as it's visited.
    ///
    /// - Complexity: O(n) time where n is the number of nodes, O(h) space where h is
    ///              the height of the tree (due to recursion stack)
    public func DFSTraverse() {

        // Check for valid node
        guard let key = self.tvalue else {
            print("no key provided..")
            return
        }

        // Process left subtree
        if let left = self.left {
            left.DFSTraverse()
        }

        print("...the value is: \(key) - height: \(self.height)..")

        // Process right subtree
        if let right = self.right {
            right.DFSTraverse()
        }
    }

    /// Performs a depth-first search traversal with a transformation function
    ///
    /// This variant of DFS traversal applies a transformation formula to each node's value
    /// during the in-order traversal. The formula is provided as a trailing closure that
    /// takes the current node and returns a new value of the same type.
    ///
    /// This is useful for batch updates to tree values, such as doubling all values,
    /// applying a discount, or normalizing data.
    ///
    /// - Parameter formula: A closure that takes a node and returns the new value to store
    /// - Complexity: O(n) time where n is the number of nodes, O(h) space where h is
    ///              the height of the tree (due to recursion stack)
    ///
    /// Example usage:
    /// ```swift
    /// // Double all values in the tree
    /// root.DFSTraverse { node in
    ///     return (node.tvalue as! Int) * 2
    /// }
    /// ```
    public func DFSTraverse(withFormula formula: (BSNode<T>) -> T) {

        // Check for valid node
        guard self.tvalue != nil else {
            print("no key provided..")
            return
        }

        // Process left subtree
        if let left = self.left {
            left.DFSTraverse(withFormula: formula)
        }

        // Apply transformation formula
        let newKey: T = formula(self)
        self.tvalue! = newKey

        print("...the updated value is: \(self.tvalue!) - height: \(self.height)..")

        // Process right subtree
        if let right = self.right {
            right.DFSTraverse(withFormula: formula)
        }
    }
}
