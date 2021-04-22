//
//  Deque.swift
//  
//
//  Created by Wayne Bishop on 4/12/21.
//

import Foundation

/**
   Deque (Deck) algorithm. A simplified model of building references
   from both sides of the chained model.

 - Complexity: O(n) - linear time as well as O(1) - constant time
   for prepend operations.
 */

public class Deque <T>: Sequence, IteratorProtocol {

    var head = LLNode<T>()

    private var iterator: LLNode<T>?
    private var times: Int = 0


    public init() {
    //playgrounds support
    }

    
    /// Add a new item to the beginning of the list - O(1)
    /// - Parameter item: The item to be added
    
    public func prepend(_ item: T) {

        let childToUse = LLNode<T>()
        childToUse.tvalue = item
        
        childToUse.next = head
        head = childToUse
    }

    
    /// Add a new item to the end of the list - O(n)
    /// - Parameter item: The item to be added
    
    public func append(_ item: T) {

        guard head.tvalue != nil else {
            head.tvalue = item
            return
        }

        var current: LLNode = head

        let childToUse = LLNode<T>()
        childToUse.tvalue = item


        //find the next position - O(n)
        while let position = current.next {
            current = position
        }

        current.next = childToUse
        childToUse.previous = current

    }


    //MARK: Iterator protocol conformance

    //iterates through each item
    public func next() -> T? {

    //print("iterator called..")

    //check starting reference
    if times == 0 {
     iterator = head
    }
         

    //assign next instance
    if let item = iterator {
     if let tvalue = item.tvalue {
         iterator = item.next
         times += 1
         return tvalue
     }
    }

    //reset timer
    times = 0

    return nil

    }



}
