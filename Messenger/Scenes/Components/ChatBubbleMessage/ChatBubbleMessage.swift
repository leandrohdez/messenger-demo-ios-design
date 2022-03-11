//
//  ChatBubbleMessage.swift
//  Messenger
//
//  Created by Leandro Hernandez on 11/3/22.
//

import SwiftUI

struct ChatBubbleMessage: View {
    
    @State var message: Models.MessageModel
    
    private var own: Bool = true
    
    init(ownMessage message: Models.MessageModel) {
        self.own = true
        self.message = message
    }
    
    init(message: Models.MessageModel) {
        self.own = false
        self.message = message
    }
    
    var body: some View {
        
        if self.own {
            HStack(alignment: .top, spacing: 8) {
                Spacer(minLength: 64)
                Text(self.message.text)
                    .font(.system(size: 17))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.ui.ultramarineBlue)
                    .foregroundColor(Color.white)
                    .cornerRadius(16)
                Image(self.message.userImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
            }
            .padding(.trailing, 8)
        } else {
            HStack(alignment: .top, spacing: 8) {
                Image(self.message.userImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                Text(self.message.text)
                    .font(.system(size: 17))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.ui.light)
                    .foregroundColor(Color.ui.spaceCadet)
                    .cornerRadius(16)
                Spacer(minLength: 64)
            }
            .padding(.leading, 8)
        }
    }
}
