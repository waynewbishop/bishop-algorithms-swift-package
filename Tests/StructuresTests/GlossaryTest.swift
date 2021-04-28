//
//  GlossaryTest.swift
//  
//
//  Created by Wayne Bishop on 4/28/21.
//
import XCTest


@testable import Structures


class GlossaryTest: XCTestCase {
    
    //called before each test invocation
    override func setUp() {
        super.setUp()
    }
    
    //test basic glossary functionality
    func testGlossaryStrings() {
        
        let vehicals = Glossary<String, String>()
        
        //add new values
        vehicals.updateValue("Porshe", forKey: "Car")
        vehicals.updateValue("Tesla", forKey: "Electric")
        vehicals.updateValue("Cessna", forKey: "Plane")
        
        //check for existing value
        if let results = vehicals.valueForKey("Car") {
            print("car is: \(results)")
        }
        else {
            XCTFail("test failed: not able to find glossary value..")
        }
        
        
        //test for non-existing key
        XCTAssertNil(vehicals.valueForKey("Boat"), "test failed: value does not exist..")
        

    }
    
    //test glossary closure method - mimics Swift SDK
    func testGlossaryClosure() {
            
        let bids = Glossary<String, Float>()
        
        //add new auction values
        bids.updateValue(20.0, forKey: "Tim")
        bids.updateValue(50.0, forKey: "Sruti")
        bids.updateValue(20.0, forKey: "Wayne") //same duplicate value as tim..
        
        let results = bids.firstIndex { (value: Float) -> Bool in
            return (value == 50 ? true : false)
        }
        
        print("first value over 50 found at glossary index: \(results!)")
                
    }
    
    
}
