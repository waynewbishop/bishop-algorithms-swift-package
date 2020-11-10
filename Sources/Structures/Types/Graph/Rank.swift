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

public class Rank: Equatable, Comparable {

 var destination: Vertex
 var score: Int

    public init() {
        
        self.destination = Vertex()
        self.score = 0
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
