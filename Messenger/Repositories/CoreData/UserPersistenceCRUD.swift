//
//  UserPersistenceCRUD.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation
import CoreData

class UserPersistenceCRUD {
    
    static let shared = UserPersistenceCRUD()
    
    //
    func read() -> [UserPersistenceEntity] {
        
        let context = PersistenceController.shared.container.viewContext
        
        let entity = UserEntity(context: context)

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.entity.name ?? "")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            
            let result = try context.fetch(request)
            
            if let fetchResult = result as? [NSManagedObject] {
                
                var items: [UserPersistenceEntity] = []
                
                for result in fetchResult {
                    if let id = result.value(forKey: "id") as? UUID,
                       let name = result.value(forKey: "name") as? String,
                       let image = result.value(forKey: "image") as? String {
                        
                        items.append(UserPersistenceEntity(id: id, name: name, image: image))
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
    func save(entity persistenceEntity: UserPersistenceEntity) -> Bool {

        let context = PersistenceController.shared.container.viewContext

        let entity = UserEntity(context: context)

        entity.id       = persistenceEntity.id
        entity.name     = persistenceEntity.name
        entity.image    = persistenceEntity.image

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
    func delete(entity persistenceEntity: UserPersistenceEntity) -> Bool {

        let context = PersistenceController.shared.container.viewContext

        let entity = UserEntity(context: context)

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
