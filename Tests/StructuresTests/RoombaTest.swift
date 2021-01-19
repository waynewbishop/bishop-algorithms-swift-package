//
//  RoombaTest.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 8/16/16.
//  Copyright © 2016 Arbutus Software Inc. All rights reserved.
//

import XCTest

@testable import Structures


class RoombaTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    //todo: write unit test that provides coordinates and can determine a threshold..
    func testSampleRoom() {
        
        //start is relative to where device starts
        let starting = Vector()
        let roomba = Roomba<Vector>(starting)
        
        /*
         note: this functionality mimics the triggered event of the device
         receiving information as to where the turn occurred. as a result,
         the algorithm can determine when the specified room is cleaned.
         */
        
        let first = Vector(1, 0)
        roomba.trackDeviceTurn(first)
        
        let second = Vector(3, 0)
        roomba.trackDeviceTurn(second)
        
        let third = Vector(-3, 0)
        roomba.trackDeviceTurn(third)
        
        let fourth = Vector(-3, -1)
        roomba.trackDeviceTurn(fourth)

        print("initial threshold is: \(roomba.threshold)")
       
        
        
        //overapping events
        let fifth = Vector(0, 0)
        roomba.trackDeviceTurn(fifth)
        
        let sixth = Vector(3, 0)
        roomba.trackDeviceTurn(sixth)
        
        let seventh = Vector(0, 0)
        roomba.trackDeviceTurn(seventh)
        
        
        print("revised threshold is: \(roomba.threshold)")

        
        /*
         as part of the implementation, we can also track
         the history of turns and overlaps using a priority
         queue
         */
        
        if let items = roomba.history.peek() {
            for s in items {
                print("vector: \(s.tvalue!) was passed: \(s.count)")
            }
        }
        
    } //end function
    
}
