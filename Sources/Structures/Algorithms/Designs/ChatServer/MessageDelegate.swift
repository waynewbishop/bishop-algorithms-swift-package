//
//  MessageDelegate.swift
//  
//
//  Created by Wayne Bishop on 6/2/21.
//

import Foundation

protocol MessageDelegate {
    
    func didReceiveMessage(chat: Message)
    func willRecieveMessage(chat: Message)
}

//todo: create working class to
//invoke specific callback messages..

