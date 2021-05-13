//
//  Trie.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 8/18/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
  Custom data structure used with `Trie` algorithms.
 */

public class TrieNode {
        
    var tvalue: String? //ap
    var children: Array<TrieNode>  //app
    var isFinal: Bool  //false
    var level: Int  //1

    
  public init() {
        self.children = Array<TrieNode>()
        self.isFinal = false
        self.level = 0
    }
    
}



