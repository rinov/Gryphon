//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

// ConnectionError represents an error that occurs while processing for a request.
public enum ConnectionError: ErrorType {
    
    // RequestError represents that occurs an error while sending a request.
    case requestError(ErrorType)
    
    // ResponseError represents that occurs an error while getting a result of request.
    case responseError(ErrorType)
    
    // Error of connection.
    case connectionError(ErrorType)
    
}