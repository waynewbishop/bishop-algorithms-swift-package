//
//  ModelPresenter.swift
//  Structures
//
//  Created by Wayne Bishop on 7/26/17.
//  Copyright © 2017 Arbutus Software Inc. All rights reserved.
//
import Foundation


class ModelPresenter {
    
    
    let service: ModelService = ModelService()
    
    //use the protocol as a type
    weak var modelDelegate: ModelDelegate?
    
    
    func setControllerDelegate(modelDelegate: ModelDelegate?) {
        self.modelDelegate = modelDelegate
    }

    
    //delegation model - presenter contacts service / updates controller
    func processContent(withElement element: Int) {
        
        
        //post starting message - presenter notifies controller
        modelDelegate?.willProcessContent(message: "starting process..")
        
        
       let results = service.processContent(element)

        
        //post results message - presenter notifies controller
        modelDelegate?.didProcessContent(results: results)
        
    }    
    
}
