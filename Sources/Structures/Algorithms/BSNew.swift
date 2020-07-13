//
//  BSNew.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/13/20.
//  Copyright © 2017 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
 Self-balancing binary search tree (BST). Elements are positioned based on the
 value. After insertion, the model is checked for balance and automatically completes required rotations.
 
 - Important:  As the tree expands with additional nodes, the entire structure is reevaluated to check for possible left or right imbalances.
 To track potential issues, `BSNode` values  are passed via reference to a `Stack` data structure for processing.
 */

class BSNew <T: Comparable>{
    
    var root = BSNode<T>()
    private var stack = Stack<BSNode<T>>()

    
    func append(_ item: T) {
        
        
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
        
       
        //recalculate tree height
       self.rebalance()
        
        
    } //end function

    
    
//MARK: Stack Memoization Process

    
/**
Stack `BSNode` elements for later processing - memoization.
 
- Important:  As the tree expands with additional nodes, the entire structure is reevaluated to check for
 possible left or right imbalances. To track potential issues, `BSNode` values  are passed via reference to a `Stack` data structure
 for processing.
*/

    private func push(element: inout BSNode<T>) {
         stack.push(element)
     }
    
    
/**
 Determine tree height and balance. As the tree expands with additional nodes, the entire structure is reevaluated to check for
possible left or right imbalances.To track potential issues, `BSNode` values  are passed via reference to a `Stack` data structure
for processing.
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
                    //TODO: determine left or right rotation code here..
                }
                
                
                //remove stacked item
                stack.pop()
                
            }
        
      }

    
//MARK: Height Measurement and Balancing
    
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
    
    
   private func isTreeBalanced(for element: BSNode<T>) -> Bool {
        
        //use absolute value to measure imbalance
        if (abs(getHeight(of: element.left) - getHeight(of: element.right)) <= 1) {
            return true
        }
        else {
            return false
        }
        
    }
    
    
    
//MARK: Rotation Methods
        
    private func rotateLeft(element: BSNode<T>) {
        //code goes here..
    }


    
    private func rotateRight(element: BSNode<T>) {
        //code goes here..
    }
    
        
}




