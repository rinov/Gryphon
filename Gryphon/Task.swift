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
    
    // Initializer must declare both fullfill and reject cases.
    public typealias Initializer = (_: Fulfill, _: Reject) -> Void

    // The default value of maximum retry count.
    private let maximumRetryCount: Int = 10
    
    // The default value of maximum interval time(ms).
    private let maximumIntervalTime: Double = 10000.0
    
    // Fullfil handler.
    private var fulfill: Fulfill?
    
    // Reject handler.
    private var reject: Reject?

    // Cancel handler.
    private var cancel: Cancel?
    
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

        executeRequest()
        
    }
    
    // MARK: Private Methods

    private func executeRequest() {
        
        initializer?({ response in
            
            self.fulfill?(response)
            
        }){ error in
            
            self.reject?(error)
            
            self.doRetry()
        }

    }
    
    // If `retry` count is one or more.
    
    private func doRetry() {

        if retry > maximumRetryCount {
            
            fatalError("The retry count is too many.\nPlease check it again.")
            
        }
        
        if retry > 0 {
            
            retry -= 1

            if interval > maximumIntervalTime {
                
                fatalError("the interval time is too much.\nPlease check it again.")
                
            }
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64( interval / 1000 * Double(NSEC_PER_SEC)))

            dispatch_after(delayTime, dispatch_get_main_queue()) { 

                self.executeRequest()

            }

            
        }

    }
    
}
