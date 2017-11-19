//
//  API.swift
//  Gryphon
//
//  Created by Ryo Ishikawa on 9/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
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
            return "Gryphon-Tutorial.php"
        }
        
        // Returns message(String) from server or error reason(Error).
        class func getMessage() -> Task<String, Error> {
            let task = Task<String, Error> { result in
                let url = URL(string: baseURL + path)!
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                let session = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject],
                        let message = json?[0]["result"] as? String else {
                            result(.error(ResponseError.unexceptedResponse(error as AnyObject)))
                            return
                    }
                    result(.response(message))
                })
                session.resume()
            }
            return task
        }
        
        // Returns status code if the submittion is succeeded.
        class func postMessage() -> Task<Int, Error> {
            let task = Task<Int, Error> { result in
                let url = URL(string: baseURL + path)!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                let session = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                    if 200...299 ~= statusCode {
                        result(.response(statusCode))
                    }else{
                        result(.error(ResponseError.unacceptableStatusCode(statusCode)))
                    }
                })
                session.resume()
            }
            return task
        }
    }
}
