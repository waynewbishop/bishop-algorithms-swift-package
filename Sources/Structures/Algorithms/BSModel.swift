//
//  BSModel.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/13/20.
//  Copyright © 2017 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
 Self-balancing binary search tree (BST). Elements are positioned based on the
 value. After insertion, the model is checked for balance and automatically completes required rotations.
 
 - Important:  As the tree expands with additional nodes, the entire structure is reevaluated to check for possible left or right imbalances. To track potential issues, `BSNode` values  are passed via reference to a `Stack` data structure for processing.
 */

public class BSModel <T: Comparable>{
    
    var root = BSNode<T>()
    private var stack = Stack<BSNode<T>>()
    
    public init() {
        //package support
    }
    

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

    
    
    /**
     Finds an element in the specified `BSNew` instance.
     
     - Complexity: O(log n) - logarithmic time.
     */
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

    
/**
Store `BSNode` references for later processing - memoization.
 
- Important:  As the tree expands with additional nodes, the `BSTree` structure is reevaluated to check for
 possible left or right imbalances. To track potential issues, `BSNode` values  are passed via reference to a `Stack` data structure for processing.
*/

    private func push(element: inout BSNode<T>) {
         stack.push(element)
     }
    
    
/**
 Determine tree height and balance. As the tree expands with additional nodes, the entire structure is reevaluated to check for possible left or right imbalances.To track potential issues, `BSNode` values  are passed via reference to a `Stack` data structure for processing.
 */
    
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
    
    
/**
 Determine tree height and balance. As the tree expands with additional nodes, the entire structure is reevaluated to check for possible left or right imbalances.To track potential issues, `BSNode` values  are passed via reference to a `Stack` data structure for processing.
 */

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


/**
 Determine tree height and balance. As the tree expands with additional nodes, the entire structure is reevaluated to check for possible left or right imbalances.To track potential issues, `BSNode` values  are passed via reference to a `Stack` data structure for processing.
 */
    
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
    
    private func getHeight(of node: BSNode<T>?) -> Int {
         
             
         //check empty leaves
         guard let bsNode = node else {
             return -1
         }

         return bsNode.height
     }
    
    
    
    private func setHeight(for node: BSNode<T>) {
         
         var nodeHeight: Int = 0
         
        //compare to calculate height
        nodeHeight = max(getHeight(of: node.left), getHeight(of: node.right)) + 1
        node.height = nodeHeight
        
     }
    
    
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
        
    public func printTree(_ element: BSNode<T>) {
        print("left is : \(element.left!.tvalue!) | root is: \(element.tvalue!)  | right is : \(element.right!.tvalue!)..")
    }
            
    
} //end class
