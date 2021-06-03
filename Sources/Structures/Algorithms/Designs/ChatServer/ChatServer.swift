//
//  ChatServer.swift
//  
//
//  Created by Wayne Bishop on 6/2/21.
//

import Foundation

class ChatServer {
    
    var tlist = Set<Transcript>()
    var accounts = Array<Account>()
        
    init() {
        //code goes here..
    }
    
    func addAccount(_ account: inout Account) {
        accounts.append(account)  //reference being added..
    }
    
    
    func sendMessage(message: Message) {
        //check for an existing transcript
        
        //todo: if the message transcript is nil
        //create a new one and associate with the message.
        
        //todo: send "message" to delegate method to post..
    }
    
}
