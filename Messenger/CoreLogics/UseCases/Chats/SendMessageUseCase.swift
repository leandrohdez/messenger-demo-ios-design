//
//  DemoUseCase.swift
//  Messenger
//
//  Created by Leandro Hernandez on 4/3/22.
//

import Foundation
import PromiseKit

enum SendMessageCaseResult {
    case success
    case unknownError
}

class SendMessageUseCase: BaseUseCase {
    
    private let message: ChatMessage
    
    private let user: User
    
    //
    init(message: ChatMessage, to user: User) {
        self.message = message
        self.user = user
    }
    
    override func execute() {
        super.execute()
        self.runPromises()
    }
    
}

//
extension SendMessageUseCase {
    
    //
    private func runPromises() {
        firstly {
            self.promiseFetchMainUser()
        }.then { user in
            self.promiseSaveMessage(user: user)
        }.done { _ in
            self.finish(caseResult: SendMessageCaseResult.success)
        }.catch { _ in
            self.finish(caseResult: SendMessageCaseResult.unknownError)
        }
    }
    
}

// MARK: - Promises
extension SendMessageUseCase {
    
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
    private func promiseSaveMessage(user: MainUser) -> Promise<Bool> {
        return Promise<Bool> { seal in
            let entity = MessagePersistenceEntity(
                id: UUID(),
                fromUserId: user.id,
                toUserId: self.user.id,
                text: self.message.text,
                date: self.message.date
            )
            let result = MessagePersistenceCRUD.shared.save(entity: entity)
            seal.fulfill(result)
        }
    }
}
