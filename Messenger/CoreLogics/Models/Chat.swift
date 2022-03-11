//
//  Chat.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation

class Chat: Equatable {
   
    let user: User
    
    let conversation: [ChatMessage]
    
    //
    init(user: User, conversation: [ChatMessage] = []) {
        self.user = user
        self.conversation = conversation
    }
    
    //
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return (lhs.user.id == rhs.user.id)
    }
}
