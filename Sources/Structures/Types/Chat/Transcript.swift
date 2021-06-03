//
//  Transcript.swift
//  
//
//  Created by Wayne Bishop on 6/2/21.
//

import Foundation

/// Acts a bundle of messages

class Transcript: Hashable {  //todo: transcripts are many-to-many relationship..
    
    var list = Stack<Message>()
    let uuid = UUID()

    
    //add a new message to the list
    func newMessage(_ message: Message) {
        list.push(message)
    }
    
    
    //hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    //equatable conformance
    public static func == (lhs: Transcript, rhs: Transcript) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
