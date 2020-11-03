//
//  TrieTest.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 10/14/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import XCTest

@testable import Structures


class TrieTest: XCTestCase {
    
    var testTrie = Trie()

    
    override func setUp() {
        super.setUp()
        
        XCTAssertNotNil(testTrie, "Trie instance not correctly intialized..")

        /*
        //add words to data structure
        testTrie.append(word: "Ball")
        testTrie.append(word: "Balls")
        testTrie.append(word: "Ballard")
        testTrie.append(word: "Bat")
        testTrie.append(word: "Bar")
        */
        
        testTrie.append(word: "Apple")
        testTrie.append(word: "App")
        testTrie.append(word: "Append")
        
    }
    
    
    func testTraverseWithPrefix() {

        
        if let wordList = testTrie.traverse(using: "Ap") {
           print("word list is: \(wordList)")
        }
        else {
            XCTFail("test failed: word list not returned")
        }
    }
    

    func testTraverseWithWord() {
        
        if let wordList = testTrie.traverse(using: "Append") {
           print("word list is: \(wordList)")
        }
        else {
            XCTFail("test failed: word list not returned")
        }
        
    }

    
    
    //testing false search results
    func testTraverseNoExist() {
        
        let keyword = "Barstool"
        
        if testTrie.traverse(using: keyword) != nil {
            XCTFail("test failed: \(keyword) incorrectly found in trie..")
        }

    }
    
}
