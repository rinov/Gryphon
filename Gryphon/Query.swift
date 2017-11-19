//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

public final class Query {
    public init() {}

    public subscript(key: String) -> AnyObject? {
        get {
            return hasKey(key) ? queries[key] : nil
        }
        set {
            queries[key] = newValue
        }
    }
    
    public var queries: [String: AnyObject] = [:]

    public var isEmpty: Bool {
        return queries.isEmpty
    }
    
    public var count: Int {
        return queries.count
    }
    
    // Returns an URL format query.
    public var absoluteString: String {
        return joinElements()
    }
    
    // Returns an URL format query with Base64 encoding.
    public var absoluteStringWithBase64: String? {
        guard let body = absoluteString.data(using: String.Encoding.utf8) else { return nil }
        return body.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }
    
    @discardableResult
    public func append<T>(_ key: String, value: T?) -> Self {
        guard let value = value else { return self }
        queries[key] = value as AnyObject
        return self
    }

    public func hasKey(_ key: String) -> Bool {
        guard let _ = queries[key] else { return false }
        return true
    }
    
    // MARK: Private Methods
    fileprivate func joinElements() -> String {
        return queries.reduce("") { query, queries in
            query + "&" + queries.0 + "=" + String(describing: queries.1)
        }
    }
    
}
