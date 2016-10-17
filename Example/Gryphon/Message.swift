//
//  Message.swift
//  Gryphon
//
//  Created by Ryo Ishikawa on 10/16/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

// Example for response model of Messages API
final class Message {
    
    var result: String
    
    init() {
        fatalError()
    }
    
    init(message: String) {
        result = message
    }
    
}
