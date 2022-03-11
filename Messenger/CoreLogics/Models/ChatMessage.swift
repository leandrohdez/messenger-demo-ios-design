//
//  ChatMessage.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation

class ChatMessage: Equatable {
    
    let id: UUID
    
    let user: User
    
    let text: String
    
    let date: Date
    
    //
    init(id: UUID = UUID(), user: User, text: String, date: Date = Date()) {
        self.id = id
        self.user = user
        self.text = text
        self.date = date
    }
    
    //
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        return (lhs.id == rhs.id)
    }
}
