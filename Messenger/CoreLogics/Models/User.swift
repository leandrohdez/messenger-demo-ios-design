//
//  User.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation

class User: Equatable {
    
    let id: UUID
    
    let name: String
    
    let image: String
    
    //
    init(id: UUID, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    //
    static func == (lhs: User, rhs: User) -> Bool {
        return (lhs.id == rhs.id)
    }
}
