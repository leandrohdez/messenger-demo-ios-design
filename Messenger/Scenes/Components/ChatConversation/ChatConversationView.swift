//
//  ChatConversationView.swift
//  Messenger
//
//  Created by Leandro Hernandez on 11/3/22.
//

import SwiftUI

struct ChatConversationView: View {
    
    @Binding var messages: [Models.MessageModel]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Spacer()
                ForEach(self.messages) { message in
                    if message.isOwnerMessage {
                        ChatBubbleMessage(ownMessage: message)
                    } else {
                        ChatBubbleMessage(message: message)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}
