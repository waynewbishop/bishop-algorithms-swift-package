//
//  PageRank.swift
//  
//
//  Created by Wayne Bishop on 11/9/20.
//

import Foundation

/*
///Provides a basic blueprint for the implementation of a Google's pagerank.

public class PageRank {
    
    ///process for organizing and calcuating importance of graph vertices
    ///
    public func crawl(graph: inout Graph) {
        
        let startingRank: Float = roundf(Float((1 / graph.canvas.count)))

        
        //equal allocation - random surfer
        for v in graph.canvas {
            v.rank.insert(startingRank, at: 0)
        }
        
        
        for v in graph.canvas {
            
            if let currRank = v.rank.first {
                
                //calculate adjusted rank
                if v.neighbors.count > 0 {
                    
                    let assignedRank = roundf(currRank / Float(v.neighbors.count))
                    
                    for m in v.neighbors {
                        
                        if let neighborRank = m.neighbor.rank.last {
                            let newRank = neighborRank + assignedRank
                            m.neighbor.rank[1] = newRank        //revised existing rank
                        }
                    }
                    
                }
                
                //sink vertex - bring value forward
                else {
                    
                    if let sinkFirstRank = v.rank.first {
                        if let sinkCurrRank = v.rank.last {
                            v.rank[1] = sinkFirstRank + sinkCurrRank
                        }
                    }
                }
            }
        }       
    }
}
*/

