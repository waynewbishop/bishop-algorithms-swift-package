//
//  Shortner.swift
//  
//
//  Created by Wayne Bishop on 2/10/21.
//

import Foundation

public class Shortnener {
    
    private var users = Array<User>()
    var sharedLinks = Dictionary<Int, Link>()
    var analytics = Dictionary<Link, Table<Int>>()  //todo: instead of a table object we will manage an Array of type analytics

    
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
    func newLink(for user: inout User, with cleartext: String) {
        
        let link = Link(cleartext, user)
        
        //the list of user links is updated via reference
        user.links.append(link)
        
        //the public dictionary is updated
        sharedLinks[link.short] = link
    }

    
    
    //obtain link history - O(1)
    func getAnalytics(for link: Link) -> Table<Int>? {
        
        guard let records = analytics[link] else {
            return nil
        }
        
        return records
    }

    
    //MARK: Redirect functionality
    

    //someone clicked on a link
    func redirect(short: Int) -> String? {
        
        //obtain dictionary link - O(1)
        guard let link = sharedLinks[short] else {
            return nil
        }

        
        /*
        note: the analytics model is built using a custom table
        object. this will count occurences based on a specified
         equatable value. 
        */
        
        if let records = analytics[link] {
            records.add(200)
            analytics[link] = records
        }
        else {
            let table = Table<Int>(200)
            analytics[link] = table
        }
                        
        return link.cleartext
    }
            
    
}
