//
//  PageRank.swift
//  
//
//  Created by Wayne Bishop on 11/9/20.
//

import Foundation


///Provides a basic blueprint for the implementation of a Google's pagerank.

public class PageRank {
    
    ///process for organizing and calcuating importance of graph vertices
    ///
    public func crawl(graph: inout Graph) {
                
        let startingRank: Float = roundf(Float((1 / graph.canvas.count)))
        
        //equal allocation - random surfer
        for v in graph.canvas {
            v.rank.push(startingRank)
        }
        
        
        for v in graph.canvas {
            
            //obtain current rank
            if let currRank = v.rank.peek() {
                let assignedRank = roundf(currRank / Float(v.neighbors.count))
                
                for n in v.neighbors {
                    
                    if n.neighbor.rank.count >= 2 {
                        //add new rank to existing rank
                    }
                    else {
                        n.neighbor.rank.push(assignedRank)
                    }
                }
            }
            
        } //end for
        
        
    } 
    
    //ensure vertex probability equals 1
    private func recentProbability(_ graph: Graph) {
        
    }
    
}
