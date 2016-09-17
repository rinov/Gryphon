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
    
    let proxy = "http://"
    
    let version = "v1"
    
}

extension API {

    final class Twitter: Requestable {

        //MARK: Endpoint infomation
        
        static let baseURL = "https://api.twitter.com/1.1/statuses/"
        
        enum Router: String {
            
            case timeline = "user_timeline.json"
            
            case follow = "follow.json"
            
            case follower = "follower.json"
            
        }
        
        static var router: Router = .timeline

        //MARK: Requestable
        
        static var headerFields: [String: String] {
            
            // Customize your header
            return [:]
        
        }
        
        static var path: String {

            return baseURL + router.rawValue
            
        }
        
        //MARK: Task type
        
        typealias TaskType = Task<Timeline,ErrorType>
        
        
        //MARK: API request
        
        static func getTimeline() -> TaskType {
            
            let task: TaskType = TaskType { success, failure in
                
                Alamofire.request(.POST, path)
                    .responseJSON(completionHandler: { response in

                        print(response.result.value)
                        
                        let yourOwnCheck = true
                        
                        if yourOwnCheck {
                            
                            let timeline = Timeline()
                            
                            // Object mapping in your favorite way
                            
                            success(timeline)
                            
                        }else{
                            
                            failure(ResponseError.unexceptedResponse(response.result.value ?? ""))
                            
                        }
                        
                        
                    })
                
            }
            
            return task
            
        }
    
        
    }
    
}