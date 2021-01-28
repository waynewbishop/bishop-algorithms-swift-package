//
//  Space.swift
//  
//
//  Created by Wayne Bishop on 1/19/21.
//

import Foundation


public class Space: Hashable {
    
    let name: Int
    var reservation = Reservation()
    let uuid = UUID()
    
    
    public init(name: Int) {
        self.name = name
    }
        
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    
    //equatable conformance
    public static func == (lhs: Space, rhs: Space) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    
}
