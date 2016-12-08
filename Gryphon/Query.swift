//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

public final class Query {
    
    public init() {}
    
    public var isEmpty: Bool {

        return queries.isEmpty
        
    }
    
    public var count: Int {
        
        return queries.count
        
    }

    public var queries: [String: AnyObject] = [:]
    
    // Returns an URL format query.
    public var absoluteString: String {

        return joinElements()
    
    }
    
    // Returns an URL format query with Base64 encoding.
    public var absoluteStringWithBase64: String {
        
        let body = absoluteString.data(using: String.Encoding.utf8)

        let base64Str = body!.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        
        return base64Str
        
    }
    
    @discardableResult
    public func append<T: Hashable>(_ key: String, value: T?) -> Self {
        
        guard let object = value as? AnyObject else { return self }
        
        queries[key] = object
        
        return self
    }
    
    public func hasKey(_ key: String) -> Bool {
        
        guard let _ = queries[key] else { return false }
        
        return true
        
    }
    
    // MARK: Private Methods
    
    fileprivate func joinElements() -> String {
        
        let valueSeparator = "="
        
        let querySeparator = "&"
        
        return queries.reduce("") { query, queries in
            
            query + querySeparator + queries.0 + valueSeparator + String(describing: queries.1)
        
        }

    }
    
}
