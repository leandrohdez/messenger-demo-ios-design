//
//  UserPersistenceEntity_Constructions.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation

extension User {
    
    convenience init(entity: UserPersistenceEntity) {
        self.init(
            id: entity.id,
            name: entity.name,
            image: entity.image
        )
    }
    
    //
    func persistenceEntity() -> UserPersistenceEntity {
        return UserPersistenceEntity(
            id: self.id,
            name: self.name,
            image: self.image
        )
    }
    
}
