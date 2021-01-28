//
//  Reservation.swift
//  
//
//  Created by Wayne Bishop on 1/19/21.
//

import Foundation

public class Reservation : Hashable {
    
    var space: Space?
    var start: Date?
    var end: Date?
    
    var price: Float = 0.0
    let uuid = UUID()    

    
    public init() {
       //default initializer
    }
    
    public init(for space: Space) {
        self.space = space
    }

    
    public func new() -> UUID {
        return self.uuid
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
