//
//  Space.swift
//  
//
//  Created by Wayne Bishop on 1/19/21.
//

import Foundation

public class Space: Hashable {
    
    var name: String?
    let uuid = UUID()
    
    
    public init() {
        //package support
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
