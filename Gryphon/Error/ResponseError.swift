//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

// ResponseError represents an erro that occurs while getting a response object.
public enum ResponseError: Error {

    // If the status code isn't in 200 ... 299.
    case unacceptableStatusCode(Int)

    // If the response is unexpected.
    case unexceptedResponse(AnyObject)
        
}
