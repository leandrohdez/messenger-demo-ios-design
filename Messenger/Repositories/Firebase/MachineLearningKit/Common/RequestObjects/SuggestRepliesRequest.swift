//
//  SuggestRepliesRequest.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation
import MLKitSmartReply

class SuggestRepliesRequest {
    
    var conversation: [TextMessage] = []

    init(conversation: [TextMessage] = []) {
        self.conversation = conversation
    }
}
