//
//  LinkedList.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
 Generic `Linked List` algorithm used in conjunction with the `LLNode` data structure.
  */

public class LinkedList<T> {
    
    
   //new instance
   private var head = LLNode<T>()
   private var counter: Int  = 0
    
    
    public init() {
        //package support
    }
    
    //the number of items - O(1)
    var count: Int {
        return counter
    }

    
    //find subscript shortcut
    public subscript(index: Int) -> LLNode<T>? {
        get {
           return find(at: index)
        }
    }

    
    //returns all values - O(n)
    public var values: Array<T> {
        
        var current: LLNode? = head
        var results = Array<T>()
        
        while let item = current {
            if let tvalue = item.tvalue {
                results.append(tvalue)
            }
            current = item.next
        }
        
        return results
    }
    
    
    
    //empty list check
    public func isEmpty() -> Bool {
        return counter == 0 || head.tvalue == nil
    }
    
    
    
    
    //add link item
    public func append(_ tvalue: T) {
        
        
        //trivial check
        guard head.tvalue != nil else {
            head.tvalue = tvalue
            counter += 1
            return
        }
        
        
         var current: LLNode = head

         //find the next position - O(n)
         while let item = current.next {
             current = item
         }

        
         //append item
         let childToUse = LLNode<T>()
         
         childToUse.tvalue = tvalue
         childToUse.previous = current
         current.next = childToUse
       
 
        counter += 1
    }
    

    
    //print all list values
    public func printValues() {
        
        var current: LLNode? = head
        
        print("------------------")
        
        //assign the next instance
        while current != nil {
            
            if let item = current {
                if let tvalue = item.tvalue {
                    print("link item is: \(tvalue)")
                }
                current = item.next
            }
        }
        
    }
    
    
    //MARK: Key & index operations
    
    
    //obtain link at a specific index
    public func find(at index: Int) ->LLNode<T>? {
        
        //check empty conditions
        if ((index < 0) || (index > (self.count - 1)) || (head.tvalue == nil)) {
            return nil
        }
        
            
        else  {
            var current: LLNode<T> = head
            var x: Int = 0

            
            //cycle through elements
            while (index != x) {
                current = current.next!
                x += 1
            }
            
            return current
            
        } //end else
    }

    
    
    
    //insert at specific index
    public func insert(_ tvalue: T, at index: Int) {
        
        
        //check for nil conditions
        if ((index < 0) || (index > (self.count - 1))) {
            print("link index does not exist..")
        }
        
        
        //establish the head node
        guard head.tvalue != nil else {
            head.tvalue = tvalue
            counter += 1
            return
        }
        
        
        //establish the trailer, current and new items
        var current: LLNode<T>? = head
        var trailer: LLNode<T>?
        var listIndex: Int = 0
        
        
        //iterate through the list to find the insertion point
        while (current != nil) {
            
            if (index == listIndex) {
                
                let childToUse: LLNode = LLNode<T>()
                
                //create the new node
                childToUse.tvalue = tvalue
                
                
                //connect the node infront of the current node
                childToUse.next = current
                childToUse.previous = trailer
                
                
                //use optional binding when using the trailer
                if let linktrailer = trailer {
                    linktrailer.next = childToUse
                    childToUse.previous = linktrailer
                }
                
                
                //point new node to the current / previous
                current!.previous = childToUse
                
                
                //replace the head node if required
                if (index == 0) {
                    head = childToUse
                }
                
                
                break
                
            } //end if
            
            
            //iterate through to the next item
            trailer = current
            current = current?.next
            listIndex += 1
            
            
        } //end while
        
        counter += 1
        
    }

    
    
    
    //remove at specific index
    public func remove(at index: Int) {
        
        //check for nil conditions
        if ((index < 0) || (index > (self.count - 1)) || (head.tvalue == nil)) {
            print("link index does not exist..")
            return
        }
        

        var current: LLNode<T>? =  head
        var trailer: LLNode<T>?
        var listIndex: Int = 0
        
        
        //determine if the removal is at the head
        if (index == 0) {
            current = current?.next
            
            if let headitem = current {
                head = headitem
                counter -= 1
            }
            return
        }
        
        
        //iterate through the remaining items
        while current != nil {
            
            if listIndex == index {
                
                //redirect the trailer and next pointers
                trailer!.next = current?.next
                current = nil
                break
                
            }
            
            //update the assignments
            trailer = current
            current = current?.next
            listIndex += 1
            
        } //end while
        
        counter -= 1
        
    } //end function
    


    
    
  //reverse the order of a linked list
    public func reverse() {

    
    //initial condition
    guard head.tvalue != nil else {
      return
    }

    
    var current: LLNode<T>? = head

    while let item = current {
        
        //preserve list
        let next = item.next
        item.next = item.previous
        item.previous = next
        
        //advance to next record
        current = next
        
        
        if next == nil {
            head = item
        }
        
    } //end while
    

  }
    
 

    
    //MARK: Closure operations
    

    
    /*
    notes: These "generic methods" mimic the map & filter array
    functions found in the Swift standard library.
    */
    
    
    //filter list content - higher order function
    public func filter(_ formula: (LLNode<T>) -> Bool) -> LinkedList<T>? {
        
        
        //check for instance
        guard head.tvalue != nil else {
            return nil
        }
        
        
        var current: LLNode! = head
        let results = LinkedList<T>()
        
        while current != nil {
            
            //filter based on formula
            if formula(current) == true {
                if let key = current.tvalue {
                    results.append(key)
                }
            }
                        
            current = current.next
        }
        
        
        return results
        
    }
    
    
    
    //map list content - higher order function
    public func map(_ formula: (LLNode<T>) -> T) -> LinkedList<T>! {
        
        
        //check for instance
        guard head.tvalue != nil else {
            return nil
        }
        
        
        var current: LLNode! = head
        let results = LinkedList<T>()
        var newKey: T!
        
        
        while current != nil {
            
            //map based on formula
            newKey = formula(current)
            
            //add non-nil entries
            if newKey != nil {
                results.append(newKey)
            }
            
            
            current = current.next
        }
        
        
        return results
        
    }

} //end class

