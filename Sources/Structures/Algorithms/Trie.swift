// Copyright 2026 Wayne W Bishop. All rights reserved.
//
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.

import Foundation

/// A trie (prefix tree) data structure for efficient string prefix operations
///
/// This class implements a trie that stores strings character-by-character in a tree structure,
/// where words sharing common prefixes share nodes. This makes tries exceptionally efficient for:
/// - Autocomplete and typeahead search (find all words starting with "ap")
/// - Spell checking and word validation
/// - Dictionary lookups with prefix constraints
/// - Pattern matching on string prefixes
///
/// The key advantage over hash tables or binary search trees: prefix-based operations run in
/// O(k) time where k is the prefix length, independent of dictionary size. A hash table lookup
/// takes O(k) to hash the entire word, but cannot efficiently find "all words starting with X."
///
/// Example usage:
/// ```swift
/// let trie = Trie()
/// trie.append(word: "app")
/// trie.append(word: "apple")
/// trie.append(word: "apply")
///
/// // Find all words starting with "app"
/// let matches = trie["app"]  // Returns ["app", "apple", "apply"]
/// ```
///
/// - Note: This implementation uses breadth-first search for traversal operations.
public class Trie {

    /// The root node of the trie
    ///
    /// The root represents the empty string and serves as the starting point for all
    /// word insertions and searches. All words in the trie are paths from this root.
    private var root = TrieNode()

    /// Creates a new empty trie
    ///
    /// Initializes an empty trie ready to accept word insertions.
    public init() {
        //package support
    }

    /// Subscript access for finding all words with a given prefix
    ///
    /// This provides array-like syntax for prefix searches: `trie["app"]` returns all
    /// words starting with "app". Syntactic sugar for `traverse(using:)`.
    ///
    /// - Parameter word: The prefix to search for
    ///
    /// - Returns: An array of complete words with the specified prefix, or nil if no matches
    subscript(word: String) -> Array<String>? {
        get {
            return traverse(using: word)
        }
    }


    /// Inserts a word into the trie character-by-character
    ///
    /// This method builds the trie hierarchy by traversing character-by-character from root,
    /// creating new nodes as needed for each prefix. Words sharing common prefixes share nodes:
    ///
    /// For ["app", "apple"]:
    /// ```
    /// root → "a" → "ap" → "app" (isFinal) → "appl" → "apple" (isFinal)
    /// ```
    ///
    /// The algorithm:
    /// 1. Start at root (level 0)
    /// 2. For each character position, check if a child node exists for that prefix
    /// 3. If found, descend to that child; if not, create new child node
    /// 4. When reaching the word's final character, mark `isFinal = true`
    ///
    /// - Parameter keyword: The complete word to insert into the trie
    ///
    /// - Complexity: O(k) where k is the length of the word. Must visit/create one node
    ///              per character.
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
    
    /// Searches for words matching both a starting character and ending character
    ///
    /// This method performs a two-phase search:
    /// 1. Checks if any first-level children match the starting character
    /// 2. Uses breadth-first search to traverse the entire trie, looking for complete
    ///    words (nodes with `isFinal = true`) that end with the specified character
    ///
    /// This is useful for pattern matching like "find words that start with 'a' and end with 'e'"
    /// (would match "apple", "angle", etc. but not "app" or "apply").
    ///
    /// - Parameters:
    ///   - start: The required first character of matching words
    ///   - end: The required last character of matching words
    ///
    /// - Returns: `true` if at least one word matches both constraints, `false` otherwise
    ///
    /// - Complexity: O(n) where n is the total number of nodes in the trie. Must potentially
    ///              visit every node via breadth-first search.
    func filter(_ start: String, _ end: String) -> Bool {
        
        let current: TrieNode = root
        var isFirst: Bool = false
        
        //check the first level
        for child in current.children {
            
            if let tvalue = child.tvalue {
                if tvalue == start {
                    isFirst = true
                    break
                }
            }
        }
                
        guard isFirst == true else {
            return false
        }
        
        
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
                let leafValue = e.tvalue ?? "nil"
                print("adding leaf: \(leafValue) to queue..")
                    trieQueue.enQueue(e)
            }

            //check for qualifying value
            if leaf.isFinal == true {
                if let tvalue = leaf.tvalue {
                    if tvalue.last == Character(end) {
                        return true
                    }
                }
            }


            if let tvalue = leaf.tvalue {
                print("traversed leaf: \(tvalue)..")
            }
            else {
             print("traversed root..")
            }

        }
        
        
        print("traversal complete..")
        
        return false
    }
    
    /// Finds all complete words in the trie that start with the specified prefix
    ///
    /// This method implements the core autocomplete/typeahead operation:
    /// 1. **Navigate to prefix**: Traverse down the trie following the prefix characters.
    ///    If the prefix doesn't exist in the trie, return nil immediately.
    /// 2. **BFS from prefix node**: Starting from the prefix's final character node, use
    ///    breadth-first search to visit all descendant nodes.
    /// 3. **Collect complete words**: For each node marked with `isFinal = true`, add its
    ///    `tvalue` (the complete word) to the results.
    ///
    /// Example: In a trie containing ["app", "apple", "apply", "banana"]:
    /// - `traverse(using: "app")` returns `["app", "apple", "apply"]`
    /// - `traverse(using: "ban")` returns `["banana"]`
    /// - `traverse(using: "car")` returns `nil` (prefix not found)
    ///
    /// - Parameter keyword: The prefix to search for
    ///
    /// - Returns: An array of all complete words with the specified prefix, or nil if the
    ///           prefix doesn't exist in the trie
    ///
    /// - Complexity: O(k + m) where k is the prefix length (navigation phase) and m is the
    ///              number of nodes in the subtree rooted at the prefix (BFS phase)
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
                let leafValue = e.tvalue ?? "nil"
                print("adding leaf: \(leafValue) to queue..")
                    trieQueue.enQueue(e)
            }



            if leaf.isFinal == true {
                if let tvalue = leaf.tvalue {
                    wordList.append(tvalue)
                }
            }

            let leafValue = leaf.tvalue ?? "nil"
            print("traversed substring: \(leafValue)..")
            
        }
        
        print("trie traversal complete..")
                        
        return wordList
        
    } //end function
    
    
} //end class
    
    
