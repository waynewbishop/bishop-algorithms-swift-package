//
//  ModelController.swift
//  Structures
//
//  Created by Wayne Bishop on 10/21/21.
//

import Foundation

class ModelController: ModelDelegate {
    
    let presenter: ModelPresenter = ModelPresenter()
        

    //set the delegate being managed by the presenter..
    func viewDidLoad() {
        presenter.setControllerDelegate(modelDelegate: self)
    }
    
    
    //send changed state to the presenter..
    func someAction(with item: Int) {
        presenter.processContent(withElement: item)
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

