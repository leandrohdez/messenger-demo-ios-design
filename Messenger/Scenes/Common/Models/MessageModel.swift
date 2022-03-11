//
//  MessageModel.swift
//  Messenger
//
//  Created by Leandro Hernandez on 10/3/22.
//

import SwiftUI

extension Models {
    
    struct MessageModel: Identifiable {
        
        var id: UUID  {
            return message.id
        }
        
        var message: ChatMessage
        
        var text: String {
            return message.text
        }
        
        var userImage: String {
            return message.user.image
        }
        
        var isOwnerMessage: Bool {
            return (message.user is MainUser) ? true : false
        }
    }
    
}
