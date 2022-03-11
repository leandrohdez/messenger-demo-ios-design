//
//  ChatDomain.swift
//  Messenger
//
//  Created by Leandro Hernandez on 4/3/22.
//

import Foundation

class ChatDomain {
    
    static let UseCases = ChatDomain()
 
    //
    func conversation(with user: User, completion: @escaping (_ result: ConversationCaseResult) -> Void) {
        let useCase = ConversationUseCase(user: user)
        useCase.endHandle = { (resultCase) in
            if let result = resultCase as? ConversationCaseResult {
                completion(result)
            }
        }
        useCase.execute()
    }
    
    //
    func send(message: ChatMessage, to user: User, completion: @escaping (_ result: SendMessageCaseResult) -> Void) {
        let useCase = SendMessageUseCase(message: message, to: user)
        useCase.endHandle = { (resultCase) in
            if let result = resultCase as? SendMessageCaseResult {
                completion(result)
            }
        }
        useCase.execute()
    }
    
    //
    func suggestReplay(of user: User, completion: @escaping (_ result: ReplayMessageCaseResult) -> Void) {
        let useCase = ReplayMessageUseCase(of: user)
        useCase.endHandle = { (resultCase) in
            if let result = resultCase as? ReplayMessageCaseResult {
                completion(result)
            }
        }
        useCase.execute()
    }

}
