//
//  MainUserUseCase.swift
//  Messenger
//
//  Created by Leandro Hernandez on 10/3/22.
//

import Foundation

enum MainUserCaseResult {
    case success(user: MainUser)
    case unknownError
}

class MainUserUseCase: BaseUseCase {
    
    override init() {
        
    }
    
    override func execute() {
        super.execute()
        self.mockMainUser()
    }
    
}

//
extension MainUserUseCase {
    
    //
    private func mockMainUser() {
        
        let key: String = "main-user-id"
        
        let name: String = "John Doe"
        let imageName: String = "001"
        
        if UserDefaults.standard.string(forKey: key) == nil {
            UserDefaults.standard.set(UUID().uuidString, forKey: key)
        }
        
        if let id = UserDefaults.standard.string(forKey: key), let userUUID = UUID(uuidString: id) {
            
            let mainUser = MainUser(id: userUUID, name: name, image: imageName)
            self.finish(caseResult: MainUserCaseResult.success(user: mainUser))
            
        } else {
            self.finish(caseResult: MainUserCaseResult.unknownError)
        }
    }
    
}
