//
//  LinkedList.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/// A generic doubly-linked list implementation with rich functional operations
///
/// This class provides a dynamic sequence data structure where elements are stored in nodes
/// connected by bidirectional links. Unlike arrays, linked lists excel at insertions and
/// deletions at arbitrary positions (O(1) when you have a node reference), at the cost of
/// slower random access (O(n) to reach index i).
///
/// This implementation uses `LLNode<T>` which maintains both `next` and `previous` pointers,
/// enabling efficient bidirectional traversal and O(1) deletion when you have a node reference.
///
/// The class provides array-like subscript access (`list[3]`), higher-order functions
/// (`map`, `filter`), and conforms to `Sequence` for Swift's for-in loop syntax and
/// functional programming operations.
///
/// - Note: For hash table chaining (singly-linked), see `Chain`. For LIFO/FIFO access
///         patterns, see `Stack` and `Queue`.
public class LinkedList <T>: Sequence, IteratorProtocol {

   /// Reference to the first node in the list
   ///
   /// The head node represents the entire list. When the list is empty, head has no value.
   private var head = LLNode<T>()

   /// Count of elements currently in the list
   ///
   /// Maintained incrementally during append/insert/remove operations to provide O(1)
   /// count access without traversing the entire list.
   private var counter: Int  = 0

   /// Internal iterator reference for Sequence protocol conformance
   ///
   /// Tracks the current position during iteration through the list elements.
   private var iterator: LLNode<T>?

   /// Internal iteration counter for resetting iterator state
   ///
   /// Tracks how many times `next()` has been called to manage iterator lifecycle.
   private var times: Int = 0

    /// Creates a new empty linked list
    ///
    /// Initializes an empty list with a head node ready to accept the first appended value.
    public init() {
        //package support
    }

    /// The number of elements currently in the list
    ///
    /// This computed property returns the cached counter value, providing O(1) constant-time
    /// access to the list size without needing to traverse the structure.
    ///
    /// - Complexity: O(1)
    var count: Int {
        return counter
    }

    /// Subscript access to nodes by index
    ///
    /// This subscript provides array-like indexed access to linked list nodes. Returns the
    /// node at the specified index, or `nil` if the index is out of bounds.
    ///
    /// - Parameter index: The zero-based index of the node to retrieve
    ///
    /// - Returns: The `LLNode<T>` at the specified index, or `nil` if index is invalid
    ///
    /// - Complexity: O(n) linear time—must traverse from head to reach the target index
    public subscript(index: Int) -> LLNode<T>? {
        get {
           return find(at: index)
        }
    }

    /// Returns all values stored in the list as an array
    ///
    /// This property traverses the entire list from head to tail, collecting all values
    /// into an array. Useful for debugging, testing, converting to standard collection
    /// types, or when you need random access to all elements.
    ///
    /// - Complexity: O(n) where n is the number of elements in the list. Must visit
    ///              every node to build the complete array.
    ///
    /// - Returns: An array containing all values in the list in insertion order
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

    /// Checks whether the list contains any elements
    ///
    /// This method provides a semantic way to test for emptiness. Returns true if either
    /// the counter is zero or the head node has no value.
    ///
    /// - Returns: `true` if the list contains zero elements, `false` otherwise
    ///
    /// - Complexity: O(1) constant time—checks only the cached counter and head value
    public func isEmpty() -> Bool {
        return counter == 0 || head.tvalue == nil
    }
    
    /// Appends a new value to the end of the list
    ///
    /// This method adds a new value to the tail of the list, creating a new node and
    /// linking it bidirectionally with the current last node. If the list is empty, the
    /// value is stored in the head node instead.
    ///
    /// The implementation traverses the entire list to find the tail position before appending.
    /// This results in O(n) complexity. A production implementation could maintain a tail
    /// pointer for O(1) append, but this version prioritizes simplicity for educational purposes.
    ///
    /// - Parameter tvalue: The value to append to the end of the list
    ///
    /// - Complexity: O(n) linear time where n is the number of elements in the list.
    ///              Must traverse the entire list to find the tail position.
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

    /// Prints all values in the list to the console for debugging
    ///
    /// This method traverses the entire list and prints each value to standard output
    /// with a separator line. Useful for debugging and visualizing list contents during
    /// development and testing.
    ///
    /// - Complexity: O(n) where n is the number of elements in the list
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

    //MARK: Iterator protocol conformance

    /// Returns the next element in the iteration sequence
    ///
    /// This method implements the `IteratorProtocol` requirement, enabling Swift's for-in
    /// loop syntax and functional operations. The iterator traverses from head to tail,
    /// returning values in insertion order.
    ///
    /// The iterator state is managed internally via `iterator` and `times` properties.
    /// After exhausting all elements, the iterator automatically resets for potential reuse.
    ///
    /// - Returns: The next value in the list, or `nil` when iteration completes
    ///
    /// - Complexity: O(1) per call—advances to the next node via single pointer traversal
     public func next() -> T? {

         print("iterator called..")

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


    //MARK: Key & index operations

    /// Finds and returns the node at a specific index
    ///
    /// This method provides indexed access to list nodes by traversing from the head
    /// until reaching the target index. Used internally by the subscript operator.
    ///
    /// Returns `nil` if the index is negative, exceeds the list bounds, or if the
    /// list is empty.
    ///
    /// - Parameter index: The zero-based index of the node to retrieve
    ///
    /// - Returns: The `LLNode<T>` at the specified index, or `nil` if invalid
    ///
    /// - Complexity: O(n) linear time where n is the index value. Must traverse
    ///              from head to reach the target position.
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
                guard let nextNode = current.next else {
                    return nil
                }
                current = nextNode
                x += 1
            }

            return current

        } //end else
    }    /// Inserts a new value at a specific index in the list
    ///
    /// This method inserts a new node containing the value at the specified index position,
    /// shifting all subsequent elements one position to the right. The new node is linked
    /// bidirectionally with its neighbors.
    ///
    /// If inserting at index 0, the new node becomes the head. If the list is empty, the
    /// value is stored in the head node. If the index is out of bounds, prints an error
    /// message and returns without modification.
    ///
    /// - Parameters:
    ///   - tvalue: The value to insert into the list
    ///   - index: The zero-based position where the value should be inserted
    ///
    /// - Complexity: O(n) linear time where n is the index value. Must traverse from
    ///              head to reach the insertion position.
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
                if let linkCurrent = current {
                    linkCurrent.previous = childToUse
                }
                
                
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

    /// Removes the node at a specific index from the list
    ///
    /// This method removes the node at the specified index position, relinking the
    /// surrounding nodes to maintain list continuity. If removing the head node (index 0),
    /// the next node becomes the new head.
    ///
    /// If the list is empty or the index is out of bounds, returns without modification.
    ///
    /// - Parameter index: The zero-based position of the node to remove
    ///
    /// - Complexity: O(n) linear time where n is the index value. Must traverse from
    ///              head to reach the removal position.
    public func remove(at index: Int) {
        
        guard head.tvalue != nil else {
            return
        }
        
        //determine if removal is at the head
        if index == 0 {
            if let item = head.next {
                head = item
                counter -= 1
            }
            else {
                head.tvalue = nil
                counter = 0
            }
            return
        }
        
        
        var current: LLNode<T>? = head
        var trailer: LLNode<T>?
        var nodeindex: Int = 0

        
        //iterate through remaining items
        while let item = current {
            
            if nodeindex == index {
                
                //redirect the trailer and next pointers
                if let tnode = trailer {
                    if let cnode = current {
                        tnode.next = cnode.next
                    }
                }
                
                current = nil
                break
            }
            
            //update assignment
            trailer = current
            
            //advance to next record
            current = item.next
            nodeindex += 1
            
        }
        
        counter -= 1
        
    }
    
    /*
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
    
*/

    /// Reverses the order of all elements in the list
    ///
    /// This method reverses the list in-place by swapping the `next` and `previous` pointers
    /// of each node. The tail node becomes the new head, and the head node becomes the new tail.
    ///
    /// The reversal is achieved by traversing the list once and swapping the directional
    /// pointers at each node, then updating the head reference to point to what was previously
    /// the tail.
    ///
    /// If the list is empty, returns without modification.
    ///
    /// - Complexity: O(n) linear time where n is the number of elements. Must visit each
    ///              node once to swap its pointers.
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

    /// Filters the list based on a predicate closure, returning a new list with matching elements
    ///
    /// This higher-order function mimics Swift's standard `Array.filter()`. It creates a new
    /// linked list containing only the elements that satisfy the provided predicate closure.
    ///
    /// The predicate receives the `LLNode<T>` rather than just the value, allowing filtering
    /// based on node properties or position information if needed.
    ///
    /// - Parameter formula: A closure that takes a `LLNode<T>` and returns `true` if the
    ///                      element should be included in the filtered list
    ///
    /// - Returns: A new `LinkedList<T>` containing only elements that satisfy the predicate,
    ///           or `nil` if the original list is empty
    ///
    /// - Complexity: O(n) linear time where n is the number of elements in the list
    public func filter(_ formula: (LLNode<T>) -> Bool) -> LinkedList<T>? {
        
        
        //check for instance
        guard head.tvalue != nil else {
            return nil
        }
        

        var current: LLNode<T>? = head
        let results = LinkedList<T>()  //todo: make this optional..

        while let node = current {

            //filter based on formula
            if formula(node) == true {
                if let key = node.tvalue {
                    results.append(key) //new filtered list..
                }
            }

            current = node.next
        }
        
        
        return results
        
    }
    /// Transforms each element in the list using a mapping closure, returning a new list
    ///
    /// This higher-order function mimics Swift's standard `Array.map()`. It creates a new
    /// linked list by applying the transformation closure to each element, replacing the
    /// original values with the transformed results.
    ///
    /// The mapping closure receives the `LLNode<T>` rather than just the value, allowing
    /// transformations based on node properties or position information if needed. The
    /// closure must return a value of the same type `T`.
    ///
    /// - Parameter formula: A closure that takes a `LLNode<T>` and returns a transformed
    ///                      value of type `T`
    ///
    /// - Returns: A new `LinkedList<T>` containing the transformed values in the same order,
    ///           or `nil` if the original list is empty
    ///
    /// - Complexity: O(n) linear time where n is the number of elements in the list
    public func map(_ formula: (LLNode<T>) -> T) -> LinkedList<T>? {


        //check for instance
        guard head.tvalue != nil else {
            return nil
        }


        var current: LLNode<T>? = head
        let results = LinkedList<T>()


        while let node = current {

            //map based on formula
            let newKey = formula(node)
            results.append(newKey)

            current = node.next
        }


        return results

    }

} //end class

