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

final class API {}

extension API {
    
    final class Twitter: Requestable {
        
        enum Router: String {
            
            case timeline = "user_timeline.json"
            
            case follow = "follow.json"
            
            case follower = "follower.json"
            
        }
        
        static var router: Router = .timeline

        // required `Requestable`
        
        static var baseURL: String {
            
            return "https://api.twitter.com/1.1/statuses/"
            
        }

        // required `Requestable`

        static var path: String {
            
            return baseURL + router.rawValue
            
        }
        
        // `Task type` = Task<YourResponseClass,ErrorType>
        
        typealias TaskType = Task<Any,ErrorType>
        
        class func getTimeline() -> TaskType {
            
            let task = TaskType { success, failure in
                
                Alamofire.request(.POST, path)
                    .responseJSON(completionHandler: { response in

                        print(response.result.value)
                        
                        // Object mapping in your favorite way

                        let yourOwnCheck = false
                        
                        if yourOwnCheck {
                            
                            success(response)
                            
                        }else{
                            
                            failure(ResponseError.unexceptedResponse(response.description))
                            
                        }
                        
                        
                    })
                
            }
            
            return task
            
        }

    }

}