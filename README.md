Swift Structures
====================

This project provides a framework for commonly used data structures and algorithms written in Swift. While details of many algorithms exist on Wikipedia, these implementations are often written as pseudocode or are expressed in C or C++. This code project, along with its [supporting book](https://medium.com/swift-algorithms-data-structures), provides theory, instruction and guidance on many commonly used models. These educational designs can help you pass your next technical interview or build your next app.


Audience
---------------------

To best utilize this project, you should already be familiar with the basics of programming. Beyond algorithms, this code also aims to provide an alternative for learning the basics of Swift. Code examples include many Swift-specific features such as optionals, extensions, protocols and generics. Beyond Swift, audiences should be familiar with **Singleton** and **Factory** design patterns along with sets, arrays and dictionaries.


Package Benefits
---------------------

The project is an Xcode package project which brings added benefits and flexibility. The source, along with its 90+ unit tests can be opened and executed as a standalone project or included as a project dependency. Since Swift packages support all Apple platforms, **Structures** can be used in any iOS, WatchOS, MacOS, or TvOS application. Quick help documentation has also been made available for the many custom types and implementations.


```swift
import Structures

 //create a new stack
 let stack = Stack<Int>()

 //push items
 stack.push(8)
 stack.push(10)
 stack.push(2)
 stack.push(9)
 stack.push(20)

 if let item = stack.peek() {
    print("top level item is: \(String(describing: stack.peek()))") //prints 20
 }

 //remove item from structure
 stack.pop()
```

Style Guide
---------------------

In addition to the over 90 included unit tests, this project also contains a sample **Swift Playground** to demonstrate how one can use the custom types. Executing the example provides an interactive illustration of building a Stack data structure. Beyond the algorithm, a visual implementation is also shown using SwiftUI. 


Features
--------------------

The project features code-level examples for the following items:

+ Linked Lists
+ Binary Search
+ Insertion Sort
+ Bubble Sort
+ Selection Sort
+ Quick Sort
+ Binary Search Trees
+ Tree Balancing - Rotations
+ Stacks
+ Queues
+ Heaps & Heapsort Operations
+ Priority Queues
+ Hash Tables
+ Tries
+ Graph Theory
+ Dijkstra's Shortest Path
+ Depth-First Search
+ Breadth-First Search
+ PageRank
+ Blockchain Networks
+ Generics
+ Type Contraints
+ Protocol Extensions
+ Enumerations
+ Fibonacci Numbers
+ Dyanmic Programming
+ Closures


The Book
--------------------

Now in its **4th edition** and supporting latest version of **Swift**, [The Swift Algorithms Book](https://medium.com/swift-algorithms-data-structures) features code and color illustrations that benefits students and professionals. As an ongoing effort, I also welcome [feedback and contribution](https://github.com/waynewbishop/Structures/pulls) from others. 


Example
--------------------

```swift
// complexity: O(1) - constant time average time for all operations.
public struct Stack <T> {

   var elements : [T] = [T]()

    public init() {
        //initialization
    }
    
    //the number of items
    var count: Int {
        return elements.count
    }
    
    public func peek() -> T? {
          return elements.last
      }
  
    public mutating func push(_ element: T) {
          elements.append(element)
      }

    public mutating func pop() -> T? {
          return elements.popLast()
      }

    //swap positions
    public mutating func swapAt(lhs: Int, rhs: Int) -> () {
        self.elements.swapAt(lhs, rhs)
    }        
}
```

Getting Started
--------------------

Swift Structures has been optimized for **Swift 5.9** (e.g., Xcode 15.0) or later. The directories are organized as follows:
+ Sources - Code for all Swift data structures, algorithms and source extensions
+ Playgrounds - Getting started material plus an interactive example of Stack algorithms. 
+ Tests - 90+ unit tests with XCTest Framework


Usage
--------------------

Individuals are welcome to use the code with commercial and open-source projects. As a courtesy, please provide attribution to [Wayne Bishop](https://www.linkedin.com/in/waynebishop). For more information, review the complete [license agreement](https://github.com/waynewbishop/SwiftStructures/blob/master/License.md). 


Questions
--------------------

Have a question? Feel free to contact me on [LinkedIn](https://www.linkedin.com/in/waynebishop)</a>.
