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
    
    func testReservedCapacity() {

       let lot = ParkingLot()
       
        //first reservation
        let resA: Reservation? = lot.reserve(from: toDate("02/1/2021 08:00") , to: toDate("02/1/2021 12:00"))
        XCTAssertNotNil(resA, "reservation not made.")
        
        //enter lot with receipt
        let ticket: Ticket? = lot.enter(with: resA)
        XCTAssertNotNil(ticket, "ticket not generated..")
        
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
