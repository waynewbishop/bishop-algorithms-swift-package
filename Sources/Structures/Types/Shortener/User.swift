//
//  User.swift
//  
//
//  Created by Wayne Bishop on 2/10/21.
//

import Foundation

public class User: Hashable {
    
    var name: String?
    var links = Array<Link>()
    var uuid = UUID()
    
    public init(with name: String) {
        self.name = name
    }
    
    
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    
    //equatable conformance
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uuid == rhs.uuid
    }
        
    
}
