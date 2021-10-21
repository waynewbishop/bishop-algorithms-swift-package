//
//  ModelService.swift
//  Structures
//
//  Created by Wayne Bishop on 7/26/17.
//  Copyright © 2017 Arbutus Software Inc. All rights reserved.
//

import Foundation


class ModelService {
    
    //replicate long running process
    func processContent(_ element: Int) -> Int {
        
        //perform some basic test operation
        let output = element * 2
        
        /*
         note: In a real application, this content processing could be executed
         on a background thread through GCD or some other multithreaded execution.
         */
        sleep(2)
    
        return output
                
    }
        
}

