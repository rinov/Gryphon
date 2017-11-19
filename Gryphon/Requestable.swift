//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

// API requests must be implemented `Requestable`.
public protocol Requestable: class {
    // Base endpoint URL.
    static var baseURL: String { get }
    // The path of endpoint.
    static var path: String { get }
}
