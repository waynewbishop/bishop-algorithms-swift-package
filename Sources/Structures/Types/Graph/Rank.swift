//
//  Rank.swift
//  
//
//  Created by Wayne Bishop on 11/9/20.
//

import Foundation


/**
The meta-data structure used for tracking a graph vertex PageRank value.
Used in conjunction with HashChain and Heap data structures.
 */

public class Rank: Equatable, Comparable, Indexable {

 var destination: Vertex
 var score: Int

    public init(_ node: Vertex, starting: Int) {
        
        self.destination = node
        self.score = starting
    }

    
    public var asciiRepresentation: Int {
        return destination.tvalue.asciiRepresentation
    }
    
    //equatable conformance
    public static func == (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.score == rhs.score
    }
    
    //comparable conformance
    public static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.score < rhs.score
    }
    
}
