//
//  ChainTest.swift
//  
//
//  Created by Wayne Bishop on 8/25/20.
//

import XCTest

@testable import Structures


/**
A Hash Table implementation designed to support collisions through the process of separate chaining. Types added to the structure must conform to Indexable as well as Equatable.
*/

class ChainTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    
    func testStrings() {
    
        //test string implementation
        let slist = HashChain<String>(capacity: 3)
        
        slist.insert("Wayne")
        slist.insert("Bishop")
        slist.insert("is")
        slist.insert("a")
        slist.insert("loser")
        slist.insert("winner")
        
        
       //test string list compliance
       XCTAssertTrue(slist.contains("Wayne"), "hash set element not found..")
        
    }

        
    func testIntegers() {
        
        //test integer implementation
        let slist = HashChain<Int>(capacity: 4)
             
         slist.insert(48)
         slist.insert(22)
         slist.insert(19)
         slist.insert(4)
         slist.insert(24)
         slist.insert(99)
        
        //test int list compliance
        XCTAssertTrue(slist.contains(24), "hash set element not found..")
    }
    
        
    //test missing values
    func testMissingValues() {
        
        //new float list
        let mlist = HashChain<Int>()
        
        mlist.insert(87)
        mlist.insert(22)
                
        //element doesn't exist
        XCTAssertFalse(mlist.contains(45), "non-existent hash set element found..")
        
    }

    
}

