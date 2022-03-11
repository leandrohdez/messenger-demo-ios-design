//
//  FBMLSmartReplay_SuggestReplies.swift
//  Messenger
//
//  Created by Leandro Hernandez on 9/3/22.
//

import Foundation
import MLKitSmartReply

extension FBMLSmartReplay {
    
    
    /**
     With ML Kit's Smart Reply API, you can automatically generate relevant replies to messages.
     
     Smart Reply helps your users respond to messages quickly, and makes it easier to reply to messages on devices with limited input capabilities.

     How to use?
     =======================
     The model uses up to 10 of the most recent messages from a conversation history to generate reply suggestions.
     It detects the language of the conversation and only attempts to provide responses when the language is determined to be English.
     The model compares the messages against a list of sensitive topics and won’t provide suggestions when it detects a sensitive topic.
     If the language is determined to be English and no sensitive topics are detected, the model provides up to three suggested responses. The number of responses depends on how many meet a sufficient level of confidence based on the input to the model.
     
     Important!
     =======================
     ...
     
     - version: 1.0
     
     - parameter requestData:       Parameters needed to make the request
     - parameter completion:        Completion closure returned as the asynchronous result of the call
     - parameter responseData:      DTO object returned from the api
     - parameter error:             Error object
     
     - throws: `Error?`
     
     - returns: `Void`

     */
    
    open func suggestReplies(requestData: SuggestRepliesRequest, completion: @escaping (_ responseData: SuggestRepliesResponse?, _ error: Error?) -> Void) {
        
        SmartReply.smartReply().suggestReplies(for: requestData.conversation) { result, error in
            
            guard error == nil, let result = result else {
                return completion(nil, error)
            }
            
            if result.status == .notSupportedLanguage {
                completion(nil, MachineLearningKitError.notSupportedLanguage)
                
            } else if result.status == .noReply {
                completion(nil, MachineLearningKitError.notReplay)
            
            } else if result.status == .success {
                
                if let suggestion = result.suggestions.first {
                    completion(SuggestRepliesResponse(suggestion: suggestion.text), nil)
                } else {
                    completion(nil, MachineLearningKitError.notReplay)
                }
            }
        }
    }
    
}
