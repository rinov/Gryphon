//
//  API.swift
//  Gryphon
//
//  Created by Ryo Ishikawa on 9/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import Gryphon

final class API {

    /*
     *
     * Your common property or function.
     *
     */
    
}

extension API {
    
    final class Messages: Requestable {
        
        // required `Requestable`
        
        static var baseURL: String {
            
            return "http://rinov.jp/"
            
        }

        // required `Requestable`

        static var path: String {
            
            return baseURL + "Gryphon-Tutorial.php"
            
        }
        
        // Returns Message class
        class func getMessage() -> Task<Message, ErrorType> {
            
            let task = Task<Message, ErrorType> { success, failure in
                
                Alamofire.request(.GET, path)
                    .responseJSON(completionHandler: { response in

                        // Object mapping in your favorite way.
                        let result = response.result.value![0]["result"] as! String

                        let yourOwnCheck = true
                        
                        if yourOwnCheck {
                            
                            let message = Message(message: result)

                            success(message)
                            
                        }else{
                            
                            failure(ResponseError.unexceptedResponse(response.description))
                            
                        }
                        
                        
                    })
                
            }
            
            return task
            
        }
        
        // Returns status code
        class func postMessage() -> Task<Int, ErrorType> {
            
            let task = Task<Int, ErrorType> { success, failure in
                
                Alamofire.request(.POST, path)
                    .responseJSON(completionHandler: { response in
                        
                        // Object mapping in your favorite way
                        
                        let yourOwnCheck = true
                        
                        if yourOwnCheck {
                            
                            success(response.response?.statusCode ?? 0)
                            
                        }else{
                            
                            failure(ResponseError.unexceptedResponse(response.description))
                            
                        }
                        
                        
                    })
                
            }
            
            return task
            
        }
        
    }

}
