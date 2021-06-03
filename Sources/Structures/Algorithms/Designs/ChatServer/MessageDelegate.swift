//
//  MessageDelegate.swift
//  
//
//  Created by Wayne Bishop on 6/2/21.
//

import Foundation

protocol MessageDelegate {
    
    func didReceiveMessage()
    func willRecieveMessage()    
    func didReceiveRequest()
    func willReceiveRequest()
}

