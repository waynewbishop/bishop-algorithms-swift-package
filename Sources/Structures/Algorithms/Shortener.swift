//
//  Shortner.swift
//  
//
//  Created by Wayne Bishop on 2/10/21.
//

import Foundation

public class Shortnener {
    
    private var users = Array<User>()
    var sharedLinks = Set<Link>()

    
    public init() {
        //package support
    }
    
    
    //MARK: User functionality

    
    //new user
    func newUser(_ name: String) -> User? {
        
        let user = User(with: name)
        users.append(user)
        
        return user
    }


    //obtain links
    func linksForUser(_ user: User) -> Set<Link> {
        
        let results = sharedLinks.filter { (s: Link) -> Bool in
            return s.user == user
        }
        
        return results
    }
    
    
    //MARK: Link functionality

    
    //generate a new link
    func newLink(for user: User, with cleartext: String) {
        
        let link = Link(cleartext, user)
        self.sharedLinks.insert(link)
    }

    

    //someone clicked on a link
    func redirect(short: Int) -> String? {

        //check for link
        let first = sharedLinks.first { (s: Link) -> Bool in
            return s.short == short
        }        
        
        //unwrap
        if let link = first {
            link.analytics.append(200)
            return link.cleartext
        }
        
        //todo: update copied link with revised analytics?
        
        return nil
    }
            
    
}
