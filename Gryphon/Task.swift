//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

public final class Task<Response,Error> {

    // Success handler type.
    public typealias Fulfill = (Response) -> Void

    // Failure handler type.
    public typealias Reject = (Error) -> Void
    
    // Cancel handler type.
    public typealias Cancel = (Void) -> Void
    
    // Initializer must declare both fullfill and reject cases.
    public typealias Initializer = (_: @escaping Fulfill, _: @escaping Reject) -> Void

    // The default value of maximum retry count.
    fileprivate let maximumRetryCount: Int = 10
    
    // The default value of maximum interval time(ms).
    fileprivate let maximumIntervalTime: Double = 10000.0
    
    // Fullfil handler.
    fileprivate var fulfill: Fulfill?
    
    // Reject handler.
    fileprivate var reject: Reject?

    // Cancel handler.
    fileprivate var cancel: Cancel?
    
    // Initializer handler.
    fileprivate var initializer: Initializer?

    // Retry count
    fileprivate lazy var retry: Int = 0

    // Interval time of request
    fileprivate lazy var interval: Double = 0.0
    
    // In case of succeed, It is able to process the result of response.
    public func success(response handler: @escaping Fulfill) -> Self {
        
        fulfill = handler
        
        return self
        
    }
    
    // In case of failure, It will be able to process the error by reason.
    public func failure(error handler: @escaping Reject) -> Self {
        
        reject = handler
        
        return self
        
    }
    
    // If the request was rejected by your `validate`, It will be able to perform to your cancel at last.
    public func cancel(canceler handler: @escaping Cancel) -> Self {
        
        cancel = handler
        
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
    public init(initClosuer: @escaping Initializer ) {
        
        initializer = initClosuer

        executeRequest()
        
    }
    
    // MARK: Private Methods

    fileprivate func executeRequest() {
        
        initializer?({ response in
            
            self.fulfill?(response)
            
        }){ error in
            
            self.reject?(error)
            
            self.doRetry()
        }

    }
    
    // If `retry` count is one or more.
    
    fileprivate func doRetry() {

        if retry > maximumRetryCount {
            
            fatalError("The retry count is too many.\nPlease check the retry count again.")
            
        }
        
        if retry > 0 {
            
            retry -= 1

            if interval > maximumIntervalTime {
                
                fatalError("The interval time is too much.\nPlease check the interval time again.")
                
            }
            
            let delayTime = DispatchTime.now() + Double(Int64( interval / 1000.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

            DispatchQueue.main.asyncAfter(deadline: delayTime) { 

                self.executeRequest()

            }

            
        }

    }
    
}
