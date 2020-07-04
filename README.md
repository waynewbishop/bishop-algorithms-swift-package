Structures
====================

This project provides a framework for commonly used data structures and algorithms written in <a href="http://www.waynewbishop.com" target="_blank">Swift</a>. While details of many algorithms exists on Wikipedia, these implementations are often written as pseudocode, or are expressed in C or C++. This code project, along with its supporting book provides theory, instruction and guidance on many commonly used models to power commercial solutions including social media, database managing, gaming and beyond.  


Audience
---------------------

As a developer, you should already be familiar with the basics of programming. Beyond algorithms, this project also aims to provide an alternative for learning the basics of Swift. This includes implementations of many Swift-specific features such as optionals, extensions, protocols and generics. Beyond Swift, audiences should be familiar with **Singleton** and **Factory** design patterns along with sets, arrays and dictionaries. 


Package Benefits
---------------------

The project is organized as an Xcode Package project which brings many benefits. 



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
+ Graphs
+ Blockchain Networks
+ Dijkstra's Shortest Path
+ Depth-First Search
+ Breadth-First Search
+ Generics
+ Type Contraints
+ Protocol Extensions
+ Enumerations
+ Fibonacci Numbers
+ Dyanmic Programming
+ Closures



The Book
--------------------
Now in its **5th edition** and supporting latest version of **Swift**, the <a href="http://wwww.waynewbishop.com" target="_blank">The Swift Algorithms Book</a> features code and color illustrations that benefits students and professionals. As an ongoing effort, I also welcome <a href="https://twitter.com/waynewbishop" target="_blank">feedback</a> and contribution from others. 


Example
--------------------

```swift
    //bfs traversal with inout closure function
    func traverse(_ startingv: Vertex, formula: (_ node: inout Vertex) -> ()) {

        
        //establish a new queue
        let graphQueue: Queue<Vertex> = Queue<Vertex>()
        
        
        //queue a starting vertex
        graphQueue.enQueue(startingv)
        
        
        while !graphQueue.isEmpty() {
            
            
            //traverse the next queued vertex - Swift 4.0
            //var vitem: Vertex! = graphQueue.deQueue()
            
            
            //traverse the next queued vertex
            guard var vitem = graphQueue.deQueue() else {
                break
            }
            
            //add unvisited vertices to the queue
            for e in vitem.neighbors {
                if e.neighbor.visited == false {
                    print("adding vertex: \(e.neighbor.key) to queue..")
                    graphQueue.enQueue(e.neighbor)
                }
            }
            
            //invoke formula
            formula(&vitem)

            
        } //end while
        
        
        print("graph traversal complete..")
                
    }
```

Getting Started
--------------------

Swift Structures has been optimized for **Swift 5.3** (e.g., Xcode 12.0) or later. The directories are organized as follows:
+ Source - Code for all Swift data structures, algorithms and source extensions
+ Example - An empty iOS single-view application template
+ SwiftTests - Unit tests with XCTest Framework


Usage
--------------------
Individuals are welcome to use the code with commercial and open-source projects. As a courtesy, please provide attribution to <a href="http://www.waynewbishop.com" target="_blank">waynewbishop.com</a>. For more information, review the complete <a href="https://github.com/waynewbishop/SwiftStructures/blob/master/License.md" target="_blank">license agreement</a>. 


Questions
--------------------

Have a question? Feel free to contact me on <a href="http://www.twitter.com/waynewbishop" target="_blank">Twitter</a> or <a href="http://www.waynewbishop.com/contact" target="_blank">online</a>.
