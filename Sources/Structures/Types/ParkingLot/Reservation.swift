//
//  Reservation.swift
//  
//
//  Created by Wayne Bishop on 1/19/21.
//

import Foundation

public class Reservation <T> : Hashable {
    
    var tvalue: T?
    var space: Space?
    var timeIn: Date?
    var timeOut: Date?
    var price: Float = 0.0
    let uuid = UUID()
    
    
    public init() {
        //package support
    }

    
    public func newSpace(_ customer: T, _ space: Space,
                         _ timeIn: Date, _ timeOut: Date) -> UUID? {
        
        self.tvalue = customer
        self.space = space
        self.timeIn = timeIn
        self.timeOut = timeOut
        
        return uuid
    }
    
    
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    //equatable conformance
    public static func == (lhs: Reservation, rhs: Reservation) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
}
