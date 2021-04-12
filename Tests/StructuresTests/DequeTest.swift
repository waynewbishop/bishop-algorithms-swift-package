//
//  DequeTest.swift
//  
//
//  Created by Wayne Bishop on 4/12/21.
//

import XCTest

@testable import Structures


class DequeTest: XCTestCase {
    
    let colorList = ["red", "yellow", "blue"]
        
    override func setUp() {
        super.setUp()
    }
    
    
    //test adding from both sides of the structure
   func testSimpleDeque() {
        
        let deque: Deque = Deque<String>()
        
        for c in colorList {
            deque.append(c)  //O(n) - linear time
        }
    
        //test existing list
        self.enumerate(with: deque)
        
    
        //prepend a new color - O(1) - constant time
        deque.prepend("green")

    
        //test prepended list..
        self.enumerate(with: deque)
   }
    
    
    func enumerate(with list: Deque<String>) {
            
        //test existing order
        for d in list {
            print("color: \(d)")
        }
    }
    
    
}

