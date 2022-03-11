//
//  Models.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import SwiftUI

extension Models {
    
    struct ContactModel: Identifiable {
        
        var id: UUID  {
            return user.id
        }
        
        var user: User
        
        var image: Image {
            return Image(user.image)
        }
    }
    
}
