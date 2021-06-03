//
//  Account.swift
//  
//
//  Created by Wayne Bishop on 6/2/21.
//

import Foundation

class Account: Hashable {
    
    var name: String
    var blist = Set<Account>() //list of blocked users
    let uuid = UUID()
    
    init(name: String) {
        self.name = name
    }
    
    func newMessage(to: Account, text: String?) -> Message? {
        //todo: request transcript "container" from chat server
        return nil //stub..
    }
    
    
    func receiveMessage(from: Account) {
        //todo: this occurs after the chatServer callback has
        //posted the received message to the central transcript..
    }
    
    
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    //equatable conformance
    public static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.uuid == rhs.uuid
    }

}
