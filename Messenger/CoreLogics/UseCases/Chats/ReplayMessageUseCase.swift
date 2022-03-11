//
//  ReplayMessageUseCase.swift
//  Messenger
//
//  Created by Leandro Hernandez on 10/3/22.
//

import Foundation
import PromiseKit

enum ReplayMessageCaseResult {
    case replay(message: ChatMessage)
    case listening
    case unknownError
}

class ReplayMessageUseCase: BaseUseCase {
    
    private let user: User
    
    private var mainUser: MainUser!
    
    //
    init(of user: User) {
        self.user = user
    }
    
    override func execute() {
        super.execute()
        self.runPromises()
    }
    
}

//
extension ReplayMessageUseCase {
    
    //
    private func runPromises() {
        firstly {
            self.promiseFetchMainUser()
        }.then { _ in
            self.promiseFetchMessages()
        }.then { messages in
            self.promiseSuggestionReplay(messages: messages)
        }.then { replayText in
            self.promiseSaveReplayMessage(replayText: replayText)
        }.done { replay in
            if let replayMessage = replay {
                self.finish(caseResult: ReplayMessageCaseResult.replay(message: replayMessage))
            } else {
                self.finish(caseResult: ReplayMessageCaseResult.listening)
            }
        }.catch { _ in
            self.finish(caseResult: ReplayMessageCaseResult.unknownError)
        }
    }
    
}

//
extension ReplayMessageUseCase {
    
    //
    private func promiseFetchMainUser() -> Promise<MainUser> {
        return Promise<MainUser> { seal in
            UserDomain.UseCases.mainUser { result in
                switch result {
                case .success(let user):
                    self.mainUser = user
                    seal.fulfill(user)
                case .unknownError:
                    seal.reject(PromiseError.fail)
                }
            }
        }
    }
    
    //
    private func promiseFetchMessages() -> Promise<[ChatMessage]> {
        return Promise<[ChatMessage]> { seal in
            ChatDomain.UseCases.conversation(with: self.user) { result in
                switch result {
                case .success(let messages):
                    seal.fulfill(messages)
                case .unknownError:
                    seal.reject(PromiseError.fail)
                }
            }
        }
    }
    
    //
    private func promiseSuggestionReplay(messages: [ChatMessage]) -> Promise<String?> {
        return Promise<String?> { seal in
            
            guard let last = messages.last else { return }
            
            let requestData = SuggestRepliesRequest(conversation: [last])
            
//            let requestData = SuggestRepliesRequest(conversation: messages.suffix(10))
//
//            messages.suffix(10).forEach { msg in
//                print("\(msg.date): \(msg.text)")
//            }

            FBMLSmartReplay.shared.suggestReplies(requestData: requestData) { responseData, error in

                if error == nil, let responseData = responseData {
                    seal.fulfill(responseData.suggestion)

                } else if let serviceError = error as? MachineLearningKitError, serviceError == .notSupportedLanguage {
                    seal.fulfill(nil)

                } else if let serviceError = error as? MachineLearningKitError, serviceError == .notReplay {
                    seal.fulfill(nil)

                } else {
                    seal.reject(PromiseError.fail)
                }
            }
        }
    }
    
    //
    private func promiseSaveReplayMessage(replayText: String?) -> Promise<ChatMessage?> {
        return Promise<ChatMessage?> { seal in

            if let text = replayText {
                
                let replay = ChatMessage(id: UUID(), user: self.user, text: text, date: Date())

                let entity = MessagePersistenceEntity(
                    id: replay.id,
                    fromUserId: self.user.id,
                    toUserId: self.mainUser.id,
                    text: replay.text,
                    date: replay.date
                )
                
                MessagePersistenceCRUD.shared.save(entity: entity)
                
                seal.fulfill(replay)
            
            } else {
                seal.fulfill(nil)
            }
        }
    }
    
}
