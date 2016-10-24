//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

public final class Query {
    
    public var isEmpty: Bool {

        return queries.isEmpty
        
    }
    
    public var count: Int {
        
        return queries.count
        
    }

    public var queries: [String: AnyObject] = [:]
    
    // URL format query.
    public var absoluteString: String {

        return joinElements()
    
    }
    
    // URL format query with Base64 encoding.
    public var absoluteStringWithBase64: String {
        
        let body = absoluteString.dataUsingEncoding(NSUTF8StringEncoding)

        let base64Str = body!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        return base64Str
        
    }
    
    public func append(key: String, value: AnyObject) -> Self {
        
        queries[key] = value
        
        return self
        
    }
    
    public func append(key: String, value: AnyObject?) -> Self {

        guard let value = value else { return self }
        
        queries[key] = value
        
        return self
    }
    
    public func hasKey(key: String) -> Bool {
        
        guard let _ = queries[key] else { return false }
        
        return true
        
    }
    
    // MARK: Private Methods
    
    private func joinElements() -> String {
        
        let valueSeparator = "="
        
        let querySeparator = "&"
        
        return queries.reduce("") { query, queries in
            query + querySeparator + queries.0 + valueSeparator + String(queries.1)
        }
    }
    
}
