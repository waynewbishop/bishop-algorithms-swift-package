//
//  IntervalST.swift
//  
//  Description: binary interval search tree
//  Created by Wayne Bishop on 3/8/22.
//

import Foundation


/// Interval search tree.
/// Sorts information in tree-based model based on an
/// upper and lower comparative range

class IntervalST <T: Comparable> {

    //root node
    var root = ISTNode<T>()
        
    
    //add new items to the tree
    func append(_ low: T, _ high: T) {
        
        var current: ISTNode<T> = root
        
        //create range
        let range = low...high
        
        //check for root node
        guard root.tvalue != nil else {
            root.tvalue = range
            root.max = range.upperBound
            return
        }

        
        //create new interval
        let childToUse = ISTNode<T>()
        childToUse.tvalue = range
        childToUse.max = range.upperBound

        
        //determine positioning based on parent
        while let tvalue = current.tvalue {
            
            //update max range - as we walk down the tree
            if range.upperBound > tvalue.upperBound {
                current.max = range.upperBound
            }
            
            //is there a conflict?
            if tvalue.overlaps(range) {
                childToUse.isConflict = true
                print("overlap found..")
            }
            
            
            //check the left side
            if range.lowerBound < tvalue.lowerBound {
                
                if let lnode = current.left {
                    current = lnode
                    continue
                }
                else {
                    current.left = childToUse
                    break
                }
            }
            
            //check the right side
            if range.lowerBound > tvalue.lowerBound {
                
                if let rnode = current.right {
                    current = rnode
                }
                else {
                    current.right = childToUse
                    break
                }
            }
            
        }//end while
        
    }//end function
    
   
    
}
