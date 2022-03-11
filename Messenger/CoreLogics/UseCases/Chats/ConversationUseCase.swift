//
//  ConversationUseCase.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation
import PromiseKit

enum ConversationCaseResult {
    case success(messages: [ChatMessage])
    case unknownError
}

class ConversationUseCase: BaseUseCase {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    override func execute() {
        super.execute()
        self.runPromises()
    }
    
}

// MARK: - Promises
extension ConversationUseCase {
    
    //
    private func runPromises() {
        firstly {
            self.promiseFetchMainUser()
        }.then { mainUser in
            self.promiseFetchMessages(mainUser: mainUser)
        }.done { messages in
            self.finish(caseResult: ConversationCaseResult.success(messages: messages))
        }.catch { _ in
            self.finish(caseResult: ConversationCaseResult.unknownError)
        }
    }
    
    //
    private func promiseFetchMainUser() -> Promise<MainUser> {
        return Promise<MainUser> { seal in
            UserDomain.UseCases.mainUser { result in
                switch result {
                case .success(let user):
                    seal.fulfill(user)
                case .unknownError:
                    seal.reject(PromiseError.fail)
                }
            }
        }
    }
    
    //
    private func promiseFetchMessages(mainUser: MainUser) -> Promise<[ChatMessage]> {
        return Promise<[ChatMessage]> { seal in
            
            let items = MessagePersistenceCRUD.shared.read(userEntity: self.user.persistenceEntity())
         
            var resultMessages: [ChatMessage] = []
            
            for item in items {
                resultMessages.append(
                    ChatMessage(
                        id: item.id,
                        user: (mainUser.id == item.fromUserId) ? mainUser : self.user,
                        text: item.text,
                        date: item.date
                    )
                )
            }
            
            seal.fulfill(resultMessages)
        }
    }
    
}
