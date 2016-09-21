//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

public final class Task<Response,Error> {

    // Success handler type.
    public typealias Fulfill = Response -> Void

    // Failure handler type.
    public typealias Reject = Error -> Void
    
    // Cancel handler type.
    public typealias Cancel = Void -> Void
    
    // Validation handler type.
    public typealias Validate = Any? -> Bool
    
    // Initializer must declare both fullfill and reject cases.
    public typealias Initializer = (_: Fulfill, _: Reject) -> Void
    
    // Fullfil handler.
    private var fulfill: Fulfill?
    
    // Reject handler.
    private var reject: Reject?

    // Cancel handler.
    private var cancel: Cancel?
    
    // Validation handler.
    private var validate: Validate?
    
    // Initializer handler.
    private var initializer: Initializer?

    // Retry count
    private lazy var retry: Int = 0

    // Interval time of request
    private lazy var interval: Double = 0.0
    
    // In case of succeed, It is able to process the result of response.
    public func success(response handler: Fulfill) -> Self {
        
        fulfill = handler
        
        return self
        
    }
    
    // In case of failure, It will be able to process the error by reason.
    public func failure(error handler: Reject) -> Self {
        
        reject = handler
        
        return self
        
    }
    
    // If the request was rejected by your `validate`, It will be able to perform to your cancel at last.
    public func cancel(canceler handler: Cancel) -> Self {
        
        cancel = handler
        
        return self
        
    }
    
    // The validate function for response from your request.
    public func validate(validater handler: Validate) -> Self {
        
        validate = handler
        
        return self
        
    }

    
    // The maximum number of retry.
    public func retry(max times: Int) -> Self {
        
        retry = times
        
        return self
        
    }
    
    // The time of interval for API request.
    public func interval(milliseconds ms: Double) -> Self {

        interval = ms
        
        return self
        
    }
    
    // Initializing by closure of `initializar`.
    public init(initClosuer: Initializer ) {
        
        initializer = initClosuer
        
        initClosuer({ response in

            self.fulfill?(response)
            
        }) { error in
            
            self.reject?(error)

            self.doRetry()
            
        }
        
    }
    
    private func doRetry() {
        
        if retry > 0 {
            
            retry -= 1

            print("retry:\(retry)")
            
            initializer?({ response in
                
                self.fulfill?(response)
            
            }){ error in
                
                self.reject?(error)
            
                self.doRetry()
            }
            
        }

    }
    
}
