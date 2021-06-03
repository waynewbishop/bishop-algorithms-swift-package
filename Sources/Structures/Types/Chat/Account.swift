//
//  Account.swift
//  
//
//  Created by Wayne Bishop on 6/2/21.
//

import Foundation

class Account: Hashable {
    
    var name: String
    var tlist = Set<Transcript>()
    var blist = Set<Account>() //list of blocked users
    let uuid = UUID()
    
    //todo: how could this work in keychain?
    
    init(name: String) {
        self.name = name
    }
        
    
    func receiveMessage(message: Message) {
        //todo: this occurs after the chatServer callback has
        //posted the received message to the account transcript..
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
