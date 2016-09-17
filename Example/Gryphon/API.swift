//
//  API.swift
//  Gryphon
//
//  Created by Ryo Ishikawa on 9/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
//import Alamofire
import Gryphon

final class API {
    
    let proxy = "http://"
    
    let version = "v1"
    
}

extension API {

    final class Twitter {

        let baseURL = "http://"

        enum Router: String {
            
            case timeline = "timeline"
            
            case follow = "follow"
            
            case follower = "follower"
            
        }

        var router: Router?
        
        
        
    }
    
}