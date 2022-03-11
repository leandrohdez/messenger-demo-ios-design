//
//  MessagePersistenceCRUD.swift
//  Messenger
//
//  Created by Leandro Hernandez on 10/3/22.
//

import Foundation
import CoreData

class MessagePersistenceCRUD {

    static let shared = MessagePersistenceCRUD()

    //
    func read(userEntity: UserPersistenceEntity) -> [MessagePersistenceEntity] {

        let context = PersistenceController.shared.container.viewContext

        let entity = MessageEntity(context: context)

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.entity.name ?? "")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate = NSPredicate(format: "fromUserId == '\(userEntity.id)' or toUserId == '\(userEntity.id)'")

        do {

            let result = try context.fetch(request)

            if let fetchResult = result as? [NSManagedObject] {

                var items: [MessagePersistenceEntity] = []

                for result in fetchResult {
                    if let id = result.value(forKey: "id") as? UUID,
                       let fromUser = result.value(forKey: "fromUserId") as? UUID,
                       let toUser = result.value(forKey: "toUserId") as? UUID,
                       let text = result.value(forKey: "text") as? String,
                       let date = result.value(forKey: "date") as? Date {

                        items.append(
                            MessagePersistenceEntity(
                                id: id,
                                fromUserId: fromUser,
                                toUserId: toUser,
                                text: text,
                                date: date
                            )
                        )
                    }
                }

                return items

            } else {
                return []
            }

        } catch let error as NSError {
            print("Error CoreData: \(error.localizedDescription)")
            return []
        }
    }

    //
    @discardableResult
    func save(entity persistenceEntity: MessagePersistenceEntity) -> Bool {

        let context = PersistenceController.shared.container.viewContext

        let entity = MessageEntity(context: context)

        entity.id           = persistenceEntity.id
        entity.fromUserId   = persistenceEntity.fromUserId
        entity.toUserId     = persistenceEntity.toUserId
        entity.text         = persistenceEntity.text
        entity.date         = persistenceEntity.date

        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Error CoreData: \(error.localizedDescription)")
            return false
        }
    }


    //
    @discardableResult
    func delete(entity persistenceEntity: MessagePersistenceEntity) -> Bool {

        let context = PersistenceController.shared.container.viewContext

        let entity = MessageEntity(context: context)

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.entity.name ?? "")
        request.predicate = NSPredicate(format: "id=='\(persistenceEntity.id)'")

        if let result = try? context.fetch(request) as? [NSManagedObject] {
            for object in result {
                context.delete(object)
            }
        }

        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Error CoreData: \(error.localizedDescription)")
            return false
        }
    }
}
