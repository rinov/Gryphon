//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

// Serves query making which consisting of multiple query.

public final class Query {
    
    var isEmpty: Bool {

        return queries.isEmpty
        
    }
    
    var count: Int {
        
        return queries.count
        
    }

    //Key : Value dictionary.
    var queries: [String: AnyObject] = [:]
    
    //URL format query.
    var absoluteString: String {

        return joinElements()
    
    }
    
    //URL format query with BASE64 encoding.
    var absoluteStringWithBase64: String {
        
        let body = absoluteString.data(using: String.Encoding.utf8)

        let base64Str = body!.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        
        return base64Str
        
    }
    
    func append(_ key: String, value: AnyObject) -> Self {
        
        queries[key] = value
        
        return self
        
    }
    
    func append(_ key: String, value: AnyObject?) -> Self {

        guard let value = value else { return self }
        
        queries[key] = value
        
        return self
    }
    
    func hasKey(_ key: String) -> Bool {
        
        guard let _ = queries[key] else { return false }
        
        return true
        
    }
    
    // MARK: Private Methods
    
    fileprivate func joinElements() -> String {
        
        let valueSeparator = "="
        
        let querySeparator = "&"
        
        var absoluteQuery = ""
        
        for (key,value) in queries {
            
            absoluteQuery += querySeparator
            absoluteQuery += key
            absoluteQuery += valueSeparator
            absoluteQuery += String(describing: value)
            
        }
        
        return absoluteQuery

    }
    
}
