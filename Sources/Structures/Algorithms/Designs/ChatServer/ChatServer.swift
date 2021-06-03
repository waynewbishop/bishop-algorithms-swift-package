//
//  ChatServer.swift
//  
//
//  Created by Wayne Bishop on 6/2/21.
//

import Foundation

class ChatServer: MessageDelegate {
    
    var accounts = Array<Account>()
        
    init() {
        //code goes here..
    }
    
    func addAccount(_ account: inout Account) {
        accounts.append(account)  //reference being added..
    }

    
    //returns an enum to determine success, fail or blocked..
    func newMessage(from: inout Account, to: inout Account, text: String?) -> () {
            
        //todo: check for blocked accounts
        //encapsulate text into Message
        //send message to delegate for processing..
        
        return
    }
    
    //todo: how will we track new versus existing converstations?
        
    
    //MARK: protocol methods

    
    //callback sends message to recipient
    func didReceiveMessage(chat: Message) {
        
        if let recipient = chat.to {
            recipient.receiveMessage(message: chat)
        }
    }

    
    
    func willRecieveMessage(chat: Message) {
        //code goes here..
    }
    
}
