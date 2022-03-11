//
//  MachineLearningKitError.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation

enum MachineLearningKitError: Error {
    case invalidData
    case notSupportedLanguage
    case notReplay
}

//
extension MachineLearningKitError: CustomStringConvertible {
    
    var description: String {
        
        switch self {
        
        case .invalidData:
            return "The data provided was not correct."
            
        case .notSupportedLanguage:
            return "Smart Reply currently doesn't support the language used in the conversation."
            
        case .notReplay:
            return "Smart Reply cannot figure out a good enough suggestion."
        }
    }
}

//
extension MachineLearningKitError: LocalizedError {
    
    public var errorDescription: String? {
        
        switch self {
        
        case .invalidData:
            return NSLocalizedString("The data provided was not correct.",  comment: "Invalid data")
            
        case .notSupportedLanguage:
            return NSLocalizedString("Smart Reply currently doesn't support the language used in the conversation.",  comment: "Not Supported Language")
            
        case .notReplay:
            return NSLocalizedString("Smart Reply cannot figure out a good enough suggestion.",  comment: "No Replay")
    
        }
    }
    
}
