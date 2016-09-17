//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

// API requests must be implemented `Requestable`.
protocol Requestable : class {

    static var headerFields: [String: String] { get }
    
    static var path: String { get }
    
}
