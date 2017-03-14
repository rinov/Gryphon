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
     * Your common property or function.
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
        
        // Returns message(String) from server or error reason(Error).
        class func getMessage() -> Task<String, Error> {
            
            let task = Task<String, Error> { result in
                
                Alamofire.request(path, method: .get, encoding: JSONEncoding.default)
                    .responseJSON(completionHandler: { response in

                        // Object mapping in your favorite way.
                        guard let message = (response.result.value as! [AnyObject])[0]["result"] as? String else {
                            
                            let reason = response.result.description as AnyObject
                            
                            return result(APIResult<String>.error(ResponseError.unexceptedResponse(reason)))
                        
                        }

                        result(APIResult<String>.response(message))
                        
                    })
                
            }
            
            return task
            
        }
        
        // Returns status code if the submittion is succeeded.
        class func postMessage() -> Task<Int, Error> {
            
            let task = Task<Int, Error> { result in

                Alamofire.request(path, method: .post, encoding: JSONEncoding.default)
                    .responseJSON(completionHandler: { response in

                        guard let statusCode = response.response?.statusCode else { return }
                        
                        if 200...299 ~= statusCode {
                            result(APIResult<Int>.response(statusCode))
                        }else{
                            result(APIResult<Int>.error(ResponseError.unacceptableStatusCode(statusCode)))
                        }
                        
                    })
                
            }
            
            return task
            
        }
        
    }

}
