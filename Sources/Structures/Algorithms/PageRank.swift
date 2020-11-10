//
//  PageRank.swift
//  
//
//  Created by Wayne Bishop on 11/9/20.
//

import Foundation


///Provides a basic blueprint for the implementation of a Google's pagerank.

public class PageRank {
    
    private var scores: Heap<Rank>
    
    public init() {
        self.scores = Heap<Rank>()
    }
    
    
    var rank: Heap<Rank>? {
        return scores
    }
    
    ///Process for organizing and calcuating graph vertices
    public func crawl(_ graph: Graph) {
        
        var model = HashChain<Rank>()
        var round: Int = 0
        
        //calcuate starting score
        let sScore: Int = 100 / graph.canvas.count
        
        //add graph vertices
        for v in graph.canvas {
            let rank = Rank(v, starting: sScore)
            model.insert(rank)
        }

        
        //calculate 2nd round scores
        for b in model.buckets {
            //code goes here..
        }
        
        //obtain the latest scores and store in heap object
        
    }
            
}
