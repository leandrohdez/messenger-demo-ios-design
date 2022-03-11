//
//  SuggestRepliesRequest_AdaptiveInit.swift
//  Messenger
//
//  Created by Leandro Hernandez on 10/3/22.
//

import Foundation
import MLKitSmartReply

extension SuggestRepliesRequest {
    
    //
    convenience init(conversation: [ChatMessage]) {
        
        var textMessages: [TextMessage] = []
        
        for chatMessage in conversation {
            textMessages.append(
                TextMessage(
                    text: chatMessage.text,
                    timestamp: chatMessage.date.timeIntervalSince1970,
                    userID: chatMessage.user.id.uuidString,
                    isLocalUser: (chatMessage.user is MainUser) ? false : true
                )
            )
        }
        
        self.init(conversation: textMessages)
    }
    
}
