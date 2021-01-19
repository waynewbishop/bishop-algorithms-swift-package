//
//  ParkingLot.swift
//  
//
//  Created by Wayne Bishop on 1/19/21.
//

import Foundation

public class ParkingLot <T> {

    let ticketList = Set<Ticket<T>>()
    let reservationList = Set<Reservation<T>>()
    var total: Int = 24

    
    var capacity: Int {
        //todo: filter the ticketList base nil time-out tickets
        return 0
    }

    
    public init() {
        //package support
    }
    
    
    //make a reservation
    public func reserve() -> UUID? {        
        return nil
    }
    
    
    //enter the lot
    public func enter(item: Reservation<T>?) -> Bool {
        return false
    }
    
    
    //exit the lot
    public func exit(ticket: Ticket<T>?) {
        //return nil
    }
    
    
}
