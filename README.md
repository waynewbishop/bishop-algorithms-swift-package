Swift Structures Package
====================

This project provides a framework for commonly used data structures and algorithms written in Swift. While details of many algorithms exist on Wikipedia, these implementations are often written as pseudocode or are expressed in C or C++. This code project, along with my [Swift Algorithms Book](https://waynewbishop.github.io/swift-algorithms/), provides theory, instruction and guidance on many commonly used models. These educational designs can help you pass your next technical interview or build your next app.


Audience
---------------------

To best utilize this project, you should already be familiar with the basics of programming. Beyond algorithms, this code also aims to provide an alternative for learning the basics of Swift. Code examples include many Swift-specific features such as optionals, extensions, protocols and generics. Beyond Swift, audiences should be familiar with **Singleton** and **Factory** design patterns along with sets, arrays and dictionaries.


Package Benefits
---------------------

The project is an Xcode package project which brings added benefits and flexibility. The source, along with its 100+ unit tests can be opened and executed as a standalone project or included as a project dependency. Since Swift packages support all Apple platforms, **Structures** can be used in any iOS, WatchOS, MacOS, or TvOS application. Quick help documentation has also been made available for the many custom types and implementations.


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
    print("top level item is: \(String(describing: item))") //prints 20
 }

 //remove item from structure
 stack.pop()
```

Testing
---------------------

This project includes over **100 comprehensive unit tests** that demonstrate how to use the custom data structures and algorithms. The tests provide detailed examples of working with Binary Search Trees, Heaps, Graphs, and other complex structures.


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
+ Tree Balancing (AVL Rotations)
+ Stacks & Queues
+ Heaps & Heapsort Operations
+ Priority Queues
+ Hash Tables
+ Tries
+ Graph Theory
+ Dijkstra's Shortest Path
+ Depth-First Search
+ Breadth-First Search
+ Topological Sort
+ PageRank
+ Generics
+ Type Constraints
+ Protocol Extensions
+ Enumerations
+ Fibonacci Numbers
+ Dynamic Programming
+ Closures


The Book
--------------------

Now in its **5th edition** and supporting latest version of **Swift**, [The Swift Algorithms Book](https://waynewbishop.github.io/swift-algorithms/) features code and color illustrations that benefits students and professionals. As an ongoing effort, I also welcome [feedback and contribution](https://github.com/waynewbishop/swift-algorithms/pulls) from others.


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

Swift Structures has been optimized for **Swift 6.0** (Xcode 16) or later. The directories are organized as follows:
+ Sources - Code for all Swift data structures, algorithms and source extensions
+ Tests - 100+ comprehensive unit tests with XCTest Framework

### Installation

Add this package as a dependency in your Xcode project:

1. Go to **File → Add Package Dependencies**
2. Enter the repository URL: `https://github.com/waynewbishop/bishop-algorithms-swift-package`
3. Choose version rules and add to your target

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/waynewbishop/bishop-algorithms-swift-package", from: "1.0.0")
]
```


Usage
--------------------

Individuals are welcome to use the code with commercial and open-source projects. As a courtesy, please provide attribution to [Wayne Bishop](https://www.linkedin.com/in/waynebishop). For more information, review the complete [license agreement](https://github.com/waynewbishop/SwiftStructures/blob/master/License.md).


Questions
--------------------

Have a question? Feel free to contact me on [LinkedIn](https://www.linkedin.com/in/waynebishop)</a>.
