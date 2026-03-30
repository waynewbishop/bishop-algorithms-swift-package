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

/// A self-balancing binary search tree (AVL tree) implementation
///
/// This class provides an automatically balanced BST that maintains O(log n) performance
/// for insertions and searches by performing rotations after each insertion. The tree uses
/// the AVL balancing algorithm, which ensures that for every node, the heights of its left
/// and right subtrees differ by at most 1.
///
/// When elements are inserted, the tree:
/// 1. Places the value according to BST property (left < parent < right)
/// 2. Tracks the insertion path using stack memoization
/// 3. Walks back up the path, recalculating heights
/// 4. Performs single rotations (left or right) when imbalance is detected
///
/// The stack-based memoization approach stores node references during insertion traversal,
/// enabling efficient bottom-up rebalancing without requiring parent pointers in nodes.
///
/// - Note: This implementation uses simplified AVL rotations (single rotations only).
///         Production AVL trees would also handle double rotations (left-right, right-left)
///         for certain imbalance patterns.
public class BSModel <T: Comparable>{

    /// The root node of the binary search tree
    ///
    /// When the tree is empty, the root node has no value. All tree operations begin
    /// by accessing this root reference.
    var root = BSNode<T>()

    /// Stack for memoizing the insertion path for bottom-up rebalancing
    ///
    /// During insertion, each visited node is pushed onto this stack. After insertion
    /// completes, the stack enables efficient traversal back up the insertion path to
    /// recalculate heights and perform rotations where needed.
    private var stack = Stack<BSNode<T>>()

    /// Creates a new empty self-balancing binary search tree
    ///
    /// Initializes an empty AVL tree ready to accept elements with automatic balancing.
    public init() {
        //package support
    }
    /// Inserts a new value into the tree and performs automatic rebalancing
    ///
    /// This method implements the core AVL tree insertion algorithm:
    /// 1. Traverses the tree to find the correct insertion position (BST property)
    /// 2. Pushes each visited node onto the memoization stack during traversal
    /// 3. Inserts the new value as a leaf node
    /// 4. Calls `rebalance()` to walk back up the path and restore AVL property
    ///
    /// If the value already exists in the tree, the method returns without insertion
    /// (no duplicates allowed).
    ///
    /// - Parameter item: The value to insert into the tree
    ///
    /// - Complexity: O(log n) for balanced tree traversal + O(log n) for rebalancing
    ///              = O(log n) overall
   public func append(_ item: T) {
        
        //initial check
        guard root.tvalue != nil else {
            root.tvalue = item
            return
        }
        
        
        var current: BSNode<T> = root
        
        
        //set child to be added
        let childToUse = BSNode<T>()
        childToUse.tvalue = item
        
        
        while current.tvalue != nil {
            
            
            //push reference to stack
            self.push(element: &current)
            
            
            if let tvalue = current.tvalue {
                                
                if tvalue == item {
                    return
                }
                
                //check left side
                if item < tvalue {

                        if let lnode = current.left {
                          current = lnode
                        }
                        else {
                          current.left = childToUse
                          break
                        }
                }

                      
                //check right side
                if item > tvalue {

                    if let rnode = current.right {
                      current = rnode
                    }

                    else {
                      current.right = childToUse
                      break
                    }
                }
            }
           
        } //end while
        
       
        //recompute tree structure
       self.rebalance()
        
        
    } //end function

    /// Searches for a value in the tree
    ///
    /// This method performs standard BST search by comparing the target value against
    /// each node and traversing left (if target < node) or right (if target > node) until
    /// finding a match or reaching a nil child.
    ///
    /// Because the tree maintains AVL balance, the search path is guaranteed to be at most
    /// O(log n) in length, unlike unbalanced BSTs which can degrade to O(n) in worst case.
    ///
    /// - Parameter item: The value to search for in the tree
    ///
    /// - Returns: `true` if the value exists in the tree, `false` otherwise
    ///
    /// - Complexity: O(log n) logarithmic time for balanced tree traversal
    public func contains(_ item: T) -> Bool {

        guard root.tvalue != nil else {
            return false
        }
        
        //obtain reference
        var current: BSNode<T> = root
        
        
        while current.tvalue != nil {
        
            if let tvalue = current.tvalue {
                
                if item == tvalue {
                    return true
                }
                
                //check left side
                if item < tvalue {

                        if let lnode = current.left {
                          current = lnode
                        }
                        else {
                          return false
                        }
                }

                      
                //check right side
                if item > tvalue {

                    if let rnode = current.right {
                      current = rnode
                    }

                    else {
                        return false
                    }
                }
                                
            } //end if
            
        }
            
        
        return false
    }
    


    //MARK: Stack Memoization Process

    /// Pushes a node reference onto the memoization stack during insertion
    ///
    /// This method stores node references as we traverse down the tree during insertion.
    /// The stack captures the exact path taken from root to insertion point, enabling
    /// efficient bottom-up rebalancing without requiring parent pointers in nodes.
    ///
    /// This memoization technique trades O(log n) space (stack depth) for O(log n) time
    /// rebalancing, which is more efficient than traversing from root to find affected
    /// nodes after each insertion.
    ///
    /// - Parameter element: A reference to the BSNode being visited during traversal
    private func push(element: inout BSNode<T>) {
         stack.push(element)
     }

    /// Rebalances the tree by processing the memoized insertion path bottom-up
    ///
    /// This method implements the AVL rebalancing algorithm:
    /// 1. Pops each node from the stack (bottom-up order: child before parent)
    /// 2. Recalculates the node's height based on its children's heights
    /// 3. Checks if the node is balanced (left/right height difference ≤ 1)
    /// 4. If imbalanced, performs the appropriate rotation (left or right)
    ///
    /// The bottom-up approach ensures we update heights from leaves toward root, and any
    /// rotations performed automatically update the height of the rotated subtree.
    ///
    /// - Complexity: O(log n) where n is the number of nodes. Processes at most log n
    ///              nodes (the depth of the insertion path) with O(1) work per node.
    private func rebalance() {
          
            while stack.count > 0 {
                
                //obtain reference
                let current = stack.peek()
                
                guard let bsNode: BSNode<T> = current else {
                    print("bsnode reference not found..")
                    return
                }
                

                //recalcuate height
                setHeight(for: bsNode)
                
    
                if self.isTreeBalanced(for: bsNode) == true {
                    print("tree balanced..")
                }
                
                else {
                    
                    //determine side imbalance
                    let right = getHeight(of: bsNode.left) - getHeight(of: bsNode.right)
                    let left =  getHeight(of: bsNode.right) - getHeight(of: bsNode.left)
                    
                    if right > 1 {
                        self.rotateRight(for: bsNode)
                    }
                    
                    if left > 1 {
                        self.rotateLeft(for: bsNode)
                    }
                    
                }
                
                stack.pop()
            }
        
    } //end function
    



    //MARK: Balancing - Rotation Methods

    /// Performs a left rotation on the specified node to fix right-heavy imbalance
    ///
    /// This method handles the case where the right subtree is too tall (right-right case
    /// in AVL terminology). The rotation:
    /// 1. Saves the current node's value in a new left child
    /// 2. Promotes the right child's value to become the new root
    /// 3. Adjusts pointers: right child's right becomes new right subtree
    ///
    /// Before rotation:
    /// ```
    ///     A (imbalanced)
    ///      \
    ///       B
    ///        \
    ///         C
    /// ```
    ///
    /// After left rotation:
    /// ```
    ///       B (balanced)
    ///      / \
    ///     A   C
    /// ```
    ///
    /// - Parameter element: The root node of the subtree to rotate
    ///
    /// - Complexity: O(1) constant time—only pointer reassignments
    private func rotateLeft(for element: BSNode<T>) {
        
        //new element
        let leftChild = BSNode<T>()
        leftChild.tvalue = element.tvalue
                
        
        if let rightChild = element.right {
        
            //reset the root node
            element.tvalue = rightChild.tvalue
            element.height = self.getHeight(of: rightChild)
            
            
            //adjust right
            element.right = rightChild.right
            
        }
                        
        //assign new right node
        element.left = leftChild
        
        self.printTree(element)
        
    }
    /// Performs a right rotation on the specified node to fix left-heavy imbalance
    ///
    /// This method handles the case where the left subtree is too tall (left-left case
    /// in AVL terminology). The rotation:
    /// 1. Saves the current node's value in a new right child
    /// 2. Promotes the left child's value to become the new root
    /// 3. Adjusts pointers: left child's left becomes new left subtree
    ///
    /// Before rotation:
    /// ```
    ///         C (imbalanced)
    ///        /
    ///       B
    ///      /
    ///     A
    /// ```
    ///
    /// After right rotation:
    /// ```
    ///       B (balanced)
    ///      / \
    ///     A   C
    /// ```
    ///
    /// - Parameter element: The root node of the subtree to rotate
    ///
    /// - Complexity: O(1) constant time—only pointer reassignments
    private func rotateRight(for element: BSNode<T>) {        
        
        //new element
        let rightChild = BSNode<T>()
        rightChild.tvalue = element.tvalue
                
        
        if let leftChild = element.left {
        
            //reset the root node
            element.tvalue = leftChild.tvalue
            element.height = self.getHeight(of: leftChild)
            
            
            //adjust left
            element.left = leftChild.left
            
        }
                        
        //assign new right node
        element.right = rightChild
        
        self.printTree(element)
        
    }


    //MARK: Balancing - Height Measurement

    /// Returns the height of the specified node
    ///
    /// Height is defined as the distance from the node to its deepest leaf. Leaf nodes
    /// have height 0. This method returns -1 for nil nodes (empty children), which enables
    /// the formula: `height = max(leftHeight, rightHeight) + 1` to work correctly for leaves.
    ///
    /// - Parameter node: The node to measure, or nil
    ///
    /// - Returns: The node's height property, or -1 if the node is nil
    ///
    /// - Complexity: O(1) constant time—simply accesses stored height value
    private func getHeight(of node: BSNode<T>?) -> Int {


         //check empty leaves
         guard let bsNode = node else {
             return -1
         }

         return bsNode.height
     }

    /// Recalculates and updates the height of the specified node
    ///
    /// This method computes the node's height based on its children's heights using the
    /// standard formula: `height = max(leftHeight, rightHeight) + 1`. This must be called
    /// bottom-up after insertions or rotations to maintain accurate height information
    /// for balance checking.
    ///
    /// - Parameter node: The node to update
    ///
    /// - Complexity: O(1) constant time—uses cached child heights
    private func setHeight(for node: BSNode<T>) {

         var nodeHeight: Int = 0

        //compare to calculate height
        nodeHeight = max(getHeight(of: node.left), getHeight(of: node.right)) + 1
        node.height = nodeHeight

     }

    /// Checks whether the specified node satisfies the AVL balance property
    ///
    /// A node is balanced if the heights of its left and right subtrees differ by at most 1.
    /// This is the core AVL tree invariant that guarantees O(log n) operations.
    ///
    /// The method uses absolute value to handle both left-heavy (left > right) and
    /// right-heavy (right > left) cases uniformly.
    ///
    /// - Parameter element: The node to check for balance
    ///
    /// - Returns: `true` if the node is balanced (height difference ≤ 1), `false` otherwise
    ///
    /// - Complexity: O(1) constant time—uses cached child heights
     public func isTreeBalanced(for element: BSNode<T>) -> Bool {

        //use absolute value to measure imbalance
        if (abs(getHeight(of: element.left) - getHeight(of: element.right)) <= 1) {
            return true
        }
        else {
            return false
        }

    }
    


    //MARK: Helper function

    /// Prints a visual representation of the specified node and its children
    ///
    /// This debugging method displays the structure of a node and its immediate children
    /// in a readable format: `left | root | right`. Useful for verifying rotation logic
    /// and understanding tree structure during development.
    ///
    /// - Parameter element: The node to visualize
    ///
    /// Example output: `left is: 5 | root is: 8 | right is: 12`
    public func printTree(_ element: BSNode<T>) {

        // Get left child value
        let leftValue: String
        if let left = element.left, let value = left.tvalue {
            leftValue = "\(value)"
        } else {
            leftValue = "nil"
        }

        // Get root value
        let rootValue: String
        if let value = element.tvalue {
            rootValue = "\(value)"
        } else {
            rootValue = "nil"
        }

        // Get right child value
        let rightValue: String
        if let right = element.right, let value = right.tvalue {
            rightValue = "\(value)"
        } else {
            rightValue = "nil"
        }

        print("left is: \(leftValue) | root is: \(rootValue) | right is: \(rightValue)")
    }


} //end class
