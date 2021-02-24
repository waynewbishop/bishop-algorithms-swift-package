//
//  Link.swift
//  
//
//  Created by Wayne Bishop on 2/10/21.
//

import Foundation


public class Link: Hashable {
    
    var hash: Int
    var cleartext: String
    var description: String?
    var user: User
    
    /*
     note: since strings in swift conform to the hashable
     protocol, this allows new values to use the prebuilt
     language hash algorithm.
     */
    
    init(_ url: String, _ user: User) {
        
        self.cleartext = url
        
        //combine cleartext and user
        self.hash = url.hashValue + user.hashValue
        self.user = user
    }
    
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.hash)
    }
    
    
    //equatable conformance
    public static func == (lhs: Link, rhs: Link) -> Bool {
        return (lhs.hash == rhs.hash)
    }
    
        
}
