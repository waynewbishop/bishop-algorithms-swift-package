//
//  Ticket.swift
//  
//
//  Created by Wayne Bishop on 1/19/21.
//

import Foundation


public class Ticket : Hashable {
    
    var space: Space?
    var reservation: Reservation?
    var timeIn = Date()
    var timeOut: Date?
    var price: Float = 0.0
    let uuid = UUID()
    
    public init(_ reservation: Reservation? = nil) {
        self.reservation = reservation
    }

    //hashable conformance
   public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    
    //equatable conformance
    public static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
}
