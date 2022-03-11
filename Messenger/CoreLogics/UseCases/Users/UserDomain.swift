//
//  UserDomain.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation

class UserDomain {
    
    static let UseCases = UserDomain()

    //
    func all(completion: @escaping (_ result: UsersCaseResult) -> Void) {
        let useCase = UsersUseCase()
        useCase.endHandle = { (resultCase) in
            if let result = resultCase as? UsersCaseResult {
                completion(result)
            }
        }
        useCase.execute()
    }
    
    //
    func mainUser(completion: @escaping (_ result: MainUserCaseResult) -> Void) {
        let useCase = MainUserUseCase()
        useCase.endHandle = { (resultCase) in
            if let result = resultCase as? MainUserCaseResult {
                completion(result)
            }
        }
        useCase.execute()
    }
}
