//
//  Link.swift
//  
//
//  Created by Wayne Bishop on 2/10/21.
//

import Foundation


public class Link: Hashable {
    
    var short: Int
    var cleartext: String
    var description: String?
    var userid: UUID

    
    /*
     note: since strings in swift conform to the hashable
     protocol, this allows new values to use the prebuilt
     language hash algorithm.
     */
    
    init(_ url: String, _ user: User) {
        
        self.cleartext = url
        
        //combine cleartext and user
        self.short = url.hashValue + user.hashValue
        self.userid = user.id
    }
    
    
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.short)
    }
    
    
    //equatable conformance
    public static func == (lhs: Link, rhs: Link) -> Bool {
        return (lhs.short == rhs.short)
    }
    
        
}
