//
//  PathHeap.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 8/9/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
Used in conjunction with a `Graph`, `PathHeap` represents an optimized version of a `min heap` data structure.  It is used to define a Graph's search `Frontier` .
  */

public class PathHeap {
    
    private var heap: Array<Path>
    
    public init() {
        heap = Array<Path>()
    }
    
    
    //the number of frontier items
  public var count: Int {
        return self.heap.count
    }
    
    
    
    //obtain the minimum path
    public  func peek() -> Path? {
        
        if heap.count > 0 {
           return heap[0] //the shortest path: O(n) - constant time
        }
        else {
            return nil
        }
        
    }
    


    //remove the minimum path
    public func deQueue() {
        
        if heap.count > 0 {
            heap.remove(at: 0)
        }
        
    }
    

    //sort shortest paths into a min-heap (heapify)
    public func enQueue(_ key: Path) {
        

        heap.append(key)
    
        
        var childIndex: Float = Float(heap.count) - 1
        var parentIndex: Int = 0
        
        
        //calculate parent index
        if childIndex != 0 {
            parentIndex = Int(floorf((childIndex - 1) / 2))
        }

        
        var childToUse: Path
        var parentToUse: Path
        
        
        //use the bottom-up approach
        while childIndex != 0 {
            
            
            childToUse = heap[Int(childIndex)]
            parentToUse = heap[parentIndex]
            
            
            //swap child and parent positions
            if childToUse.total < parentToUse.total {
                heap.swapAt(parentIndex, Int(childIndex))
            }
            else {
                break
            }            
            
            //reset indices
            childIndex = Float(parentIndex)

        
            if childIndex != 0 {
                parentIndex = Int(floorf((childIndex - 1) / 2))
            }
            
            
            
        } //end while
        
        
    } //end function

    
    
}
