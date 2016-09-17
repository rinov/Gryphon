//
//  Timeline.swift
//  Gryphon
//
//  Created by Ryo Ishikawa on 9/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

// Response model
final class Timeline {
    
    var count: Int!
    
    var date: NSDate!
    
    var contents: [String]!
    
    init() {
        
        // Set default value
        
        count = 0
        
        date = NSDate()
        
        contents = ["test","test","test"]
        
    }
    
}
