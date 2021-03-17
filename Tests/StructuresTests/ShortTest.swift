//
//  ShortTest.swift
//  
//
//  Created by Wayne Bishop on 3/4/21.
//
import XCTest

@testable import Structures


class ShortTest: XCTestCase {
    
    let bitly = Shortnener()
    
    var google: Int = 0
    var amazon: Int = 0
    var yahoo: Int = 0
    
    
    override func setUp() {
        super.setUp()
    }
    
    
    //series of valid links
    func testLinksValid() {
        
        //new link
        var jason = bitly.newUser("Jason")

        //build links
        google = bitly.newLink(for: &jason, with: "www.google.com")
        amazon = bitly.newLink(for: &jason, with: "www.amazon.com")
        yahoo = bitly.newLink(for: &jason, with: "www.yahoo.com")

        
        //check user links
        XCTAssertTrue(jason.links.count > 0, "no short links created for user..")
        
        
        for link in jason.links {
            print("link is: \(link.cleartext)")
        }
        
        
        
        //O(1) - constant time dictionary lookup
        
        if let url_google = bitly.redirect(short: google) {
            print("url is: \(url_google)..")
        }
        
        if let url_amazon = bitly.redirect(short: amazon) {
            print("url is: \(url_amazon)..")
        }
        
        if let url_yahoo = bitly.redirect(short: yahoo) {
            print("url is: \(url_yahoo)..")
        }
        
        //secondary google click..
        if let url_google = bitly.redirect(short: google) {
            print("url is: \(url_google)..")
        }
        
        
        
        //iterate through the user links
        let users = bitly.users
        
        for user in users {
            for link in user.links {
                
                print("records for: \(link.cleartext)..")
                
                if let events = bitly.getEvents(for: link) {
                    for event in events.items {
                        print("\(event.tvalue!) | \(event.date)")
                    }
                }
                print()
            }
            
        } //end for
    }
    
    
}

    
