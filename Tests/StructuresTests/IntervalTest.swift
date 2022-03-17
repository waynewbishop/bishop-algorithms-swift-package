//
//  IntervalTest.swift
//  
//  https://www.geeksforgeeks.org/interval-tree/
//  Created by Wayne Bishop on 3/16/22.
//

import XCTest


@testable import Structures


class IntervalTest: XCTestCase {
    
    //called before each test invocation
    override func setUp() {
        super.setUp()
    }

    
    //test overlapping Int ranges
    func testRangeNumbers() {
        
        let invTree = IntervalST<Int>()
        
        //add items to series
        invTree.append(5, 8)
        invTree.append(1, 4)
        invTree.append(9, 12)
        
        //iterate through the model
        invTree.root.DFSTraverse()
                
    }
    
    //test overlapping date ranges
    func testRangeNumbersOverlap() {
        
        let invTree = IntervalST<Int>()
        
        //add items to series
        invTree.append(5, 8)
        invTree.append(1, 6)
        invTree.append(7, 10)
        
        //iterate through the model
        invTree.root.DFSTraverse()
    }
    
}

