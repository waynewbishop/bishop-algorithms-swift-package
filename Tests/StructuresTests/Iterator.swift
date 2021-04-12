//
//  Iterator.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 04/05/21.
//  Copyright © 2015 Arbutus Software Inc. All rights reserved.
//

import XCTest

@testable import Structures

/*
 notes: The goal of these tests is to showcase the funtionality
 of having custom data structures (organized by reference) conform
 to the features and functionality of standard Swift collection
 (e.g. Array, Dictionary and Set)
 */


class IteratorTest: XCTestCase {

    var numberList: Array<Int> = [8, 2, 10, 9, 1, 5]
    
    
    //iterate through a linked list
    func testEnumerateLinkedList() {
        
        let list = LinkedList<Int>()
        
        for s in numberList {
            list.append(s)
        }
                
        
        if list.count == 0 {
            XCTFail("test failed: no list items available..")
        }
         
        //1. list fast-enumeration - O(n)        
        for l in list {
            print("item: \(l)")
            //todo: what happens when break is called??
        }
        
        //2. enumerate based on index - O(n)
        for (i, l) in list.enumerated() {
            print("index \(i) holds: \(l)")
        }
        

        //3. find a specific value - O(n)
        //XCTAssert(list.contains(9), "test failed: no stack item found..")
        
        
        let baseValue: Int = 2
        
        //4. for-each trailing closure - O(n)
        list.forEach { value in
            print(value * baseValue) //capture scope from beyond the closure..
        }
       
        
    }
    
    
    //iterate through a queue
    func testEnumerateQueue() {
        
        let queue = Queue<Int>()
         
         //add new items
         for s in numberList {
             queue.enQueue(s)
         }
         
         if queue.count == 0 {
            XCTFail("test failed: no queue items available..")
         }
         
         //1. fast-enumeration - O(n)
         for q in queue {
             print("item: \(q)")
         }
         
         //2. enumerate based on index - O(n)
         for (i, q) in queue.enumerated() {
             print("index \(i) holds: \(q)")
         }
         

         //3. find a specific value - O(n)
        //todo: iterator is not being correctly reset once value is found..
        
      //  XCTAssert(queue.contains(9), "test failed: no stack item found..")
         
                
         let baseValue: Int = 2
         
        
         //4. for-each trailing closure - O(n)
         queue.forEach { value in
             print(value * baseValue) //capture scope from beyond the closure..
         }
        
        
    }
    

    
    //iterate through a stack
    func testEnumerateStack() {
        
       let stack = Stack<Int>()
        
        //add new items
        for s in numberList {
            stack.push(s)
        }
        
        if stack.count == 0 {
           XCTFail("test failed: no stack items available..")
        }
        
        //1. fast-enumeration - O(n)
        for t in stack {
            print("item: \(t)")
        }
        
        //2. enumerate based on index - O(n)
        for (i, s) in stack.enumerated() {
            print("index \(i) holds: \(s)")
        }
        

        //3. find a specific value - O(n)
        XCTAssert(stack.contains(9), "test failed: no stack item found..")
        
        /*
        let baseValue: Int = 2
        
        //4. for-each trailing closure - O(n)
        stack.forEach { value in
            print(value * baseValue) //capture scope from beyond the closure..
        }
        */
        
                        
    }
    

}


