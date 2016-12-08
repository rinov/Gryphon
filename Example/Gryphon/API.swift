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

    static let tutorialURL = "http://rinov.jp/"
    
}

extension API {
    
    final class Messages: Requestable {
        
        // required `Requestable`
        
        static var baseURL: String {
            
            return API.tutorialURL
            
        }

        // required `Requestable`

        static var path: String {
            
            return baseURL + "Gryphon-Tutorial.php"
            
        }
        
        // Returns Message class
        class func getMessage() -> Task<Message, Error> {
            
            let task = Task<Message, Error> { success, failure in
                
                Alamofire.request(path, method: .get, encoding: JSONEncoding.default)
                    .responseJSON(completionHandler: { response in

                        // Object mapping in your favorite way.
                        let result = (response.result.value as! [AnyObject])[0]["result"] as! String

                        if true /* This is your own validation */ {
                            
                            let message = Message(message: result)

                            success(message)
                            
                        }else{
                            
                            failure(ResponseError.unexceptedResponse(response.result.description))
                            
                        }
                        
                        
                    })
                
            }
            
            return task
            
        }
        
        // Returns status code
        class func postMessage() -> Task<Int, Error> {
            
            let task = Task<Int, Error> { success, failure in

                Alamofire.request(path, method: .post, encoding: JSONEncoding.default)
                    .responseJSON(completionHandler: { response in
                        
                        if true /* This is your own validation */ {
                            
                            success(response.response?.statusCode ?? 0)
                            
                        }else{
                            
                            failure(ResponseError.unexceptedResponse(response.result.description))
                            
                        }
                        
                        
                    })
                
            }
            
            return task
            
        }
        
    }

}
