//
//  KnowledgeTest.swift
//  
//
//  Created by Wayne Bishop on 6/28/21.
//

import Foundation
import XCTest

@testable import Structures


/*
   unit test cases specific to graph algorithms
   to test your own graph, replace the vertices and edges.
*/

class KnowledgeTest: XCTestCase {
    
    let knowledge = Knowledge<String>()
    
    var strui = Entity("Strui")
    var apple = Entity("Apple")
    var san_jose = Entity("San Jose")
    var sunny = Entity("Sunny")
    var iPhone = Entity("iPhone")
    var apple_tv = Entity("Apple TV")
    var products = Entity("Products")
    var developer = Entity("Developer")
    var one_million = Entity("1.028")
    
    
    //replicate knowledge infrastructure
    override func setUp() {
        
        knowledge.addEntity(&strui)
        knowledge.addEntity(&apple)
        knowledge.addEntity(&san_jose)
        knowledge.addEntity(&sunny)
        knowledge.addEntity(&iPhone)
        knowledge.addEntity(&apple_tv)
        knowledge.addEntity(&products)
    
    }
    
    func testKnowledgeSearch() {
        knowledge.search(term: "Tell me about main dishes and red wine")
    }
    

    func testingWorkingKnowledge() {
        
        //sruti knowledge
        knowledge.newFact(for: &strui, neighbor: &apple, token: .worksAt)
        knowledge.newFact(for: &strui, neighbor: &developer, token: .occupation)
        knowledge.newFact(for: &strui, neighbor: &san_jose, token: .livesAt)
        
        //san jose knowledge
        knowledge.newFact(for: &san_jose, neighbor: &sunny, token: .weather)
        knowledge.newFact(for: &san_jose, neighbor: &one_million, token: .population)
        
        ///apple knowledge
        knowledge.newFact(for: &apple, neighbor: &iPhone, token: .creates)
        knowledge.newFact(for: &apple, neighbor: &apple_tv, token: .creates)
        
        //product knowledge
        knowledge.newFact(for: &products, neighbor: &iPhone, token: .isA)
        knowledge.newFact(for: &products, neighbor: &apple_tv, token: .isA)

        
        //what other assocations can be made with Apple?
        if let result = knowledge.mutualFriends(of: &apple) {
            
            for t in result {
                
                if let item = t.tvalue {
                    if let entity = item.tvalue {
                        print("\(apple.tvalue!) can be associated to \(entity)'s \(t.count) mutual connections..")
                    }
                }
            }
        }
        else {
            
        }
                
                
    } //end function

} //end class

    
