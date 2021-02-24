//
//  Shortner.swift
//  
//
//  Created by Wayne Bishop on 2/10/21.
//

import Foundation

public class Shortnener {
    
    private var users = Set<User>() //todo: structure needs to be a reference (not copied)
    var sharedLinks = Set<SharedLink>()

    
    public init() {
        //package support
    }
        
    
    //create a new user
    func newUser(_ name: String) -> User? {
        
        let user = User(with: name)
        users.insert(user)
        
        return user
    }
    
    
    //create a new link
    func newLink(for user: User, with cleartext: String) {
        
        //create link
        let link = Link(cleartext, user)
        
        //associate with specified user
        user.links.append(link)
        
                
        //public shared repository
        let publicLink = SharedLink(link, cleartext)
        sharedLinks.insert(publicLink)
    }

    

    //someone clicked on a link
    func redirect(short: Int) -> String? {
        
        
        return nil
    }
    
}
