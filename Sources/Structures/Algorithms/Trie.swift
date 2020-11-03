//
//  Trie.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 10/14/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
A tree-base data structure used to define overlapping work hierarchies and permuation models.
  */

public class Trie {
    
    private var root = TrieNode()
   
    public init() {
        //package support
    }
    
    
    //find subscript shortcut
    subscript(word: String) -> Array<String>? {
        get {
            return traverse(using: word)
        }
    }
        
    
    //builds a tree hierarchy of dictionary content
    func append(word keyword: String) {
        
        //trivial case
        guard keyword.length > 0 else {
            return
        }
        
        
        var current: TrieNode = root
        

        while keyword.length != current.level {
            
            var childToUse = TrieNode()
            let searchKey = keyword.substring(to: current.level + 1)
            
            
            //print("current has \(current.children.count) children..")
            
            
            //iterate through child nodes
            for child in current.children {
                
                if (child.tvalue == searchKey) {
                    childToUse = child
                    break
                }
            }
            
            
            //new node
            if childToUse.tvalue == nil {  //todo: where is this being populated?
                childToUse.tvalue = searchKey
                childToUse.level = current.level + 1
                current.children.append(childToUse)
            }
            
            
            current = childToUse
            
            
        } //end while
        
        
        //final end of word check
        if (keyword.length == current.level) {
            current.isFinal = true
            print("end of word reached!")
            return
        }
        
    } //end function
    
    
    
    /// Employs Breadth-First Search to find one or many values based on a designated keyword prefix.
    /// - Parameter keyword: Search word or phrase
    /// - Returns: A list of possible words (optional).
    
    func traverse(using keyword: String) -> Array<String>? {
        
        
        //trivial case
        guard keyword.length > 0 else {  //this is where can set the minimum length requirements..
            return nil
        }
        
        
        var current: TrieNode = root
        var wordList = Array<String>()
        
        
        while keyword.length != current.level {
                        
            let searchKey = keyword.substring(to: current.level + 1)
            var isFound: Bool = false
            
            //iterate through any child nodes
            for child in current.children {
                
                if child.tvalue == searchKey {
                    current = child
                    isFound = true
                    break
                }                
            }
            
            if isFound == false {
                return nil
            }
            
            
        } //end while
        
        
        
        //initiate bfs process
        let trieQueue: Queue<TrieNode> = Queue<TrieNode>()
        
        
        //queue a starting vertex
        trieQueue.enQueue(current)
        
        
        while !trieQueue.isEmpty() {
                        
            //traverse the next queued vertex
            guard let leaf = trieQueue.deQueue() else {
                break
            }
            
            
            //add unvisited trie nodes to the queue
            for e in leaf.children {
                print("adding leaf: \(e.tvalue!) to queue..")
                    trieQueue.enQueue(e)
            }

            
            if leaf.isFinal == true {
                if let tvalue = leaf.tvalue {
                    wordList.append(tvalue)
                }
            }

            print("traversed substring: \(leaf.tvalue!)..")
            
        }
        
        print("trie traversal complete..")
                        
        return wordList
        
    } //end function
    
    
} //end class
    
    
