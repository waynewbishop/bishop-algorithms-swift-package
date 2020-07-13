//
//  BSTree.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/13/20.
//  Copyright © 2017 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
 Self-balancing binary search tree (BST). Elements are positioned based on the
 value. After insertion, the model is checked for balance and automatically completes required rotations.
 
 - Important:  As the tree expands with additional nodes, the entire structure is reevaluated to determine
 to check for balance and perform any required rotations. To track potential imbalance issues, `BSNode` values
 are passed via reference to a `Stack` data structure for processing.
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
    
        
    } //end function

    
    
    //MARK: Stack Memoization Process

    /**
    Stack `BSNode` elements for later processing - memoization.
     
     - Important:  As the tree expands with additional nodes, the entire structure is reevaluated to determine
     to check for balance and perform any required rotations. To track potential imbalance issues, `BSNode` values
     are passed via reference to a `Stack` data structure for processing.
     */

    private func push(element: inout BSNode<T>) {
         stack.push(element)
     }

        
}



