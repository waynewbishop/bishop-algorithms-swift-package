//
//  PageRank.swift
//  
//
//  Created by Wayne Bishop on 11/9/20.
//

import Foundation


///Provides a basic blueprint for the implementation of a Google's pagerank.

public class PageRank {
    
    private var canvas = Graph() //represents tha graph canvas
    private var model = HashChain<String>()
    
    
    public init(for canvas: Graph) {
        self.canvas = canvas
    }
    
    ///Process for organizing and calcuating graph vertices
    public func crawl() {

    }
    

        /// Tally of PageRank results
    /// - Returns: Scores derrived PageRank algorithm
    
    public func scores() -> Heap<Rank>? {
        return nil
    }
        
}
