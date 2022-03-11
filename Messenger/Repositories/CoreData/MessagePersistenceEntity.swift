//
//  MessagePersistenceEntity.swift
//  Messenger
//
//  Created by Leandro Hernandez on 10/3/22.
//

import Foundation

struct MessagePersistenceEntity {
    var id: UUID
    var fromUserId: UUID
    var toUserId: UUID
    var text: String
    var date: Date
}
