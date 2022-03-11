//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Leandro Hernandez on 8/3/22.
//

import Foundation

class ChatViewModel: ObservableObject {
 
    @Published var mainUser: Models.ContactModel?
    
    @Published var contact: Models.ContactModel
    
    @Published var messages: [Models.MessageModel]
    
    //
    init(contact: Models.ContactModel) {
        self.contact = contact
        self.messages = []
    }
    
    //
    func fethMainUser() {
        UserDomain.UseCases.mainUser { result in
            
            switch result {
                
            case .success(let user):
                self.mainUser = Models.ContactModel(user: user)
                
            case .unknownError:
                print("Error")
            }
        }
    }
    
    //
    func fethMessages() {
        
        ChatDomain.UseCases.conversation(with: self.contact.user, completion: { result in
         
            switch result {
            
            case .success(let messages):
                self.messages = messages.map {
                    return Models.MessageModel(message: $0)
                }
            case .unknownError:
                print("Error")
            }
        })
    }
    
    //
    func send(messageText: String) {
        
        guard let mainUser = self.mainUser?.user as? MainUser else { return }
        
        let message = ChatMessage(id: UUID(), user: mainUser, text: messageText, date: Date())
        self.messages.append(Models.MessageModel(message: message))
        
        ChatDomain.UseCases.send(message: message, to: self.contact.user, completion: { result in
            switch result {
                
            case .success:
                self.suggestReplay()
                
            case .unknownError:
                print("Error")
            }
        })
    }
    
    //
    private func suggestReplay() {
        ChatDomain.UseCases.suggestReplay(of: self.contact.user) { result in
            switch result {
                
            case .replay(let message):
                self.messages.append(Models.MessageModel(message: message))
                
            case .listening:
                print("nothing")
                break
                
            case .unknownError:
                print("Error")
                break
            }
        }
    }
    
}
