//
//  MainViewModel.swift
//  Messenger
//
//  Created by Leandro Hernandez on 8/3/22.
//

import Foundation

class MainViewModel: ObservableObject {

    @Published var pinned: [Models.ContactModel]
    
    @Published var contacts: [Models.ContactModel]
    
    init() {
        self.pinned = []
        self.contacts = []
    }
    
    //
    func fetchContacts() {
        
        self.contacts = []
        UserDomain.UseCases.all { result in
            
            switch result {
                
            case .success(let contacts):
                self.contacts = contacts.map({ user in
                    return Models.ContactModel(user: user)
                })
                
                // mock pinned chats
                self.pinned = [self.contacts[2], self.contacts[6]]
                
            case .unknownError:
                print("Fetching contacts error")
            }
        }
    }
    
}
