//
//  Shortner.swift
//  
//
//  Created by Wayne Bishop on 2/10/21.
//

import Foundation

public class Shortnener {
    
    var users = Array<User>()
    var sharedLinks = Dictionary<Int, Link>()
    var history = Dictionary<Link, Events<Int>>() //history events, mapped by Link

    
    public init() {
        //package support
    }
    
    
    //MARK: User functionality

    
    //new user
    func newUser(_ name: String) -> User {
        
        let user = User(with: name)
        self.users.append(user)
        
        return user
    }
    
    
    //MARK: Link functionality

    
    //generate new link -  O(1)
    func newLink(for user: inout User, with cleartext: String) -> Int {
        
        let link = Link(cleartext, user)
        
        //links updated via reference
        user.links.append(link)

        //public dictionary update
        sharedLinks[link.short] = link

        
        return link.short
    }

    
    
    //obtain link history - O(1)
    func getEvents(for link: Link) -> Events<Int>? {
        
        guard let events = history[link] else {
            return nil
        }
        
        return events
    }

    
    //MARK: Redirect functionality
    

    //someone clicked on a link
    func redirect(short: Int) -> String? {
        
        //obtain dictionary link - O(1)
        guard let link = sharedLinks[short] else {
            return nil
        }
        
        /*
        note: the analytics / event model is built using a custom table
        object. this will group events based on a specified value
        */
        
        if let records = history[link] {
            records.add(200)
        }
        else {
            let records = Events<Int>()
            records.add(200)
            history[link] = records
        }
                
        
        return link.cleartext
    }
            
    
}
