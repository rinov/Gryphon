//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

final class Task<Response,Error> {

    // Success handler type.
    typealias Fulfill = Response -> Void

    // Failure handler type.
    typealias Reject = Error -> Void
    
    // Initializer must declare both fullfill and reject cases.
    typealias Initializer = (_: Fulfill, _: Reject) -> Void
    
    // Fullfil handler.
    private var fulfill: Fulfill?
    
    // Reject handler.
    private var reject: Reject?
    
    // In case of succeed ,It is able to process the result of response.
    func success(response handler: Fulfill) -> Self {
        
        fulfill = handler
        
        return self
        
    }
    
    // In case of failure ,It will be able to process the error by reason.
    func failure(error handler: Reject) -> Self {
        
        reject = handler
        
        return self
        
    }
    
    // Initializing by closure of initializar.
    init(@noescape initializar: Initializer ) {
        
        initializar({ response in
            
            self.fulfill?(response)
            
        }) { error in
            
            self.reject?(error)
            
        }
        
    }
    
}
