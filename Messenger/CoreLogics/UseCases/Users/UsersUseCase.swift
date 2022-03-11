//
//  UsersUseCase.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation

enum UsersCaseResult {
    case success(users: [User])
    case unknownError
}

class UsersUseCase: BaseUseCase {
    
    override init() {
        
    }
    
    override func execute() {
        super.execute()
        self.fethAllContacts()
    }
    
}

//
extension UsersUseCase {
    
    //
    private func fethAllContacts() {
        
        var entities = UserPersistenceCRUD.shared.read()
        
        if entities.isEmpty {
            self.createMockContacts()
            entities = UserPersistenceCRUD.shared.read()
        }
            
        let users = entities.map { entity in
            return User(entity: entity)
        }
        
        self.finish(caseResult: UsersCaseResult.success(users: users))
    }
    
    //
    private func createMockContacts() {
        
        let mockUser01 = User(id: UUID(), name: "Sayangku", image: "002")
        UserPersistenceCRUD.shared.save(entity: mockUser01.persistenceEntity())
        
        let mockUser02 = User(id: UUID(), name: "My lovely mom", image: "003")
        UserPersistenceCRUD.shared.save(entity: mockUser02.persistenceEntity())
        
        let mockUser03 = User(id: UUID(), name: "John Jun", image: "004")
        UserPersistenceCRUD.shared.save(entity: mockUser03.persistenceEntity())
        
        let mockUser04 = User(id: UUID(), name: "Katty parky", image: "005")
        UserPersistenceCRUD.shared.save(entity: mockUser04.persistenceEntity())
        
        let mockUser05 = User(id: UUID(), name: "Allent", image: "006")
        UserPersistenceCRUD.shared.save(entity: mockUser05.persistenceEntity())
        
        let mockUser06 = User(id: UUID(), name: "Johana", image: "001")
        UserPersistenceCRUD.shared.save(entity: mockUser06.persistenceEntity())
        
        let mockUser07 = User(id: UUID(), name: "Karim", image: "002")
        UserPersistenceCRUD.shared.save(entity: mockUser07.persistenceEntity())
    }
}
