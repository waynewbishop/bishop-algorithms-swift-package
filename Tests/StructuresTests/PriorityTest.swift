//
//  PriorityTest.swift
//  SwiftTests
//
//  Created by Wayne Bishop on 5/30/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import XCTest

@testable import Structures


class PriorityTest: XCTestCase {
    

    /*
     note: all words, characters and numbers conform to the comparable protocol
     */
                
    override func setUp() {
        // Put setup code here.
    }
    
    
    
    /// The concept of finding a palindrome permutation lies with being able to detect
    /// each character occurs exactly twice in the sequence.
    func testPalindromePermuation() {
        
        let phrase: String = "abba"
        let pqueue = Priority<Character>()
        var isPalindrome: Bool = true

        //add items to queue
        for p in phrase {
            pqueue.add(p)
        }
        
        if let results = pqueue.get() {
        
            //base analysis off the number of possible matches. even or odd.
            if (phrase.count % 2 == 0) {
               
                for letter in results {
                    if (letter.count % 2 != 0) {
                        isPalindrome = false
                        break
                    }
                }
            }
            
            //todo: contains an odd number of characters?
            
        }
        
        
        print(isPalindrome)
        
    }

    
    //test priority based on words
    func testPriorityWords() {
           
           let words: Array<String> = ["dog", "this", "a", "test", "of", "the", "emergency", "broadcast", "system", "this", "is", "only", "a", "test", "dog", "dog", "dog"]
        
        
           let pqueue = Priority<String>()
        
        
            //add items to queue
            for item in words {
                pqueue.add(item)
            }
           
           
           //iterate through the results
           
           if let results = pqueue.get() {
               for item in results {
                   if let tvalue = item.tvalue {
                     print("\(String(describing: tvalue)):\(item.count)")
                   }
                   
               }
           } //end of
            
           else {
            XCTFail()
           }        
                    
     }
    
    
    //test priority based on characters
    func testPriorityCharacters() {
          
          
          let characters: Array<Character> = ["A", "A", "C", "T", "G", "B", "G", "G"]
        
       
          let pqueue = Priority<Character>()
       
        
           //add items to queue
           for item in characters {
               pqueue.add(item)
           }
          
          
          //iterate through the results
          
          if let results = pqueue.get() {
              for item in results {
                  if let tvalue = item.tvalue {
                    print("\(String(describing: tvalue)):\(item.count)")
                  }
                  
              }
          } //end of
           
          else {
           XCTFail()
          }
                   
    }
    
    

    
    //test priority based on numbers
    func testPriorityNumbers() {
          
          
          let characters: Array<Int> = [3, 1, 1, 5, 3, 2, 6, 1]
        
       
          let pqueue = Priority<Int>()

        
           //add items to queue
           for item in characters {
               pqueue.add(item)
           }
          
          
          //iterate through the results
          
          if let results = pqueue.get() {
              for item in results {
                  if let tvalue = item.tvalue {
                    print("\(String(describing: tvalue)):\(item.count)")
                  }
                  
              }
          } //end of
           
          else {
           XCTFail()
          }
                   
    }



}
