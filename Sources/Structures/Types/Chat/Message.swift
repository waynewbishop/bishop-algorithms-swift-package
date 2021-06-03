//
//  Message.swift
//  
//
//  Created by Wayne Bishop on 6/2/21.
//

import Foundation


/// container for a chat message
class Message {
    
    var text: String?
    var from: Account?
    var to: Account?
    var transcript_id: UUID? //this acts a reference for grouping messages..

    //unique identifier
    let uuid = UUID()
    
    init() {
        
    }
}
