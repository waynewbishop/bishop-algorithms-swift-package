//
//  Model.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/26/17.
//  Copyright © 2017 Arbutus Software Inc. All rights reserved.
//
import Foundation


class ModelPresenter: ModelDelegate {
    
    
    let service: ModelService = ModelService()
    
    init() {
        service.delegate = self
    }
    
    
    //invoke delegation pattern - presenter updates the model
    func processContent(withElement element: Int) {
        service.processContent(element)
    }
    
    
    //MARK: - Delegate Methods
    
    //invoked prior to process start
    func willProcessContent(message: String) {
        print(message)
    }
    
    
    //invoked after process completion
    func didProcessContent(results: Int) {
        print("the result is: \(results)")
    }
    
}
