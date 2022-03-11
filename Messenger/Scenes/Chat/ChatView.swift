//
//  ChatView.swift
//  Messenger
//
//  Created by Leandro Hernandez on 8/3/22.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject private var viewModel: ChatViewModel
    
    //
    init(viewModel: ChatViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 24) {
                
                Spacer(minLength: 70).frame(height: 70)
                
                ChatConversationView(messages: self.$viewModel.messages)
                    .onAppear {
                        self.viewModel.fethMessages()
                    }
                
                MessageBarView(onSend: { message in
                    self.sendButtonTapped(message: message)
                })
                .ignoresSafeArea(.keyboard)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .navigationBarHidden(true)
        .overlay {
            BackNavigationBar(title: self.viewModel.contact.user.name)
        }
        .onAppear {
            self.viewModel.fethMainUser()
        }
    }
}

//
extension ChatView {
    
    //
    private func sendButtonTapped(message: String) {
        self.viewModel.send(messageText: message)
    }
    
}

