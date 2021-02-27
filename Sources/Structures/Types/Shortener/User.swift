//
//  User.swift
//  
//
//  Created by Wayne Bishop on 2/10/21.
//

import Foundation

public class User: Hashable {
    
    var name: String?
    var links = Array<Link>()  //updated by Shortnener algorithm..
    private let uuid: UUID
        
    var id: UUID {
        return self.uuid
    }
        
    public init(with name: String) {
        self.name = name
        self.uuid = UUID()
    }
    
    
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
    
    
    //equatable conformance
    public static func == (lhs: User, rhs: User) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
    
}
