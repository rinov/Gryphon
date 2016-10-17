//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

// RequestError presents an error that occurs while sending a request.
public enum RequestError: Error {
    
    // If the request doesn't conform to RequestType appropriately.
    case unacceptableFormat(String)

    // If the argument is shortage or invalid.
    case insufficientArgument(String)
    
}
