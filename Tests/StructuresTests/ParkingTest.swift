//
//  ParkingTest.swift
//  
//
//  Created by Wayne Bishop on 2/2/21.
//

import XCTest
import Foundation

@testable import Structures


class ParkingTest: XCTestCase {
        
    
    //reservation with open spaces
    func testParkingLot() {
        
        let lot = ParkingLot()

        //1. first reservation
        let resA: Reservation? = lot.reserve(from: toDate("02/1/2021 08:00") , to: toDate("02/1/2021 12:00"))
        XCTAssertNotNil(resA, "reservation not made.")
        
        
        //enter lot with receipt
        let ticketA: Ticket? = lot.enter(resA)
        XCTAssertNotNil(ticketA, "ticket not generated..")
                
        
        //2. enters lot - no reservation
        let ticketB: Ticket? = lot.enter()
        XCTAssertNotNil(ticketB, "ticket not generated..")
        
        
        
        //3. reservation conflict
        let resB: Reservation? = lot.reserve(from: toDate("02/1/2021 08:00") , to: toDate("02/1/2021 10:00"))
        XCTAssertNil(resB, "reservation mistakenly made..")
        
    }
    
    
    
    
        

    
    //MARK: Helper function
    
    //formats a date
    func toDate(_ item: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
    
        //return the formatted date
        if let results = formatter.date(from: item) {
            return results
        }
        else {
            return Date()
        }
        
    }
    
}
