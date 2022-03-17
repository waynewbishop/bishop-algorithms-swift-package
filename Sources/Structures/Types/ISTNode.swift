//
//  ISTNode.swift
//  
//  Description: Interval Search Tree Node
//  Created by Wayne Bishop on 3/8/22.
//


import Foundation


class ISTNode <T: Comparable> {
    
    var tvalue: ClosedRange<T>?
    var max: T?
    var isConflict: Bool = false
    var left: ISTNode?
    var right: ISTNode?
    
    
    
    //regular dfs traversal
    public func DFSTraverse() {
        
        //trivial condition
        guard let tvalue = self.tvalue else {
            print("no key provided..")
            return
        }

        //process the left side
        if let left = self.left {
            left.DFSTraverse()
        }
                
        print("...the range is: \(tvalue.lowerBound) - \(tvalue.upperBound)..")
 
        //process the right side
        if let right = self.right {
            right.DFSTraverse()
        }        
        
    }
    
}
