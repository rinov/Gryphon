//
//  Gryphon
//  Created by rinov on 9/17/16.
//  Copyright © 2016 rinov. All rights reserved.
//

import Foundation

// `Result` represents API response that either successful or failure.
public enum APIResult<T> {
    case response(T)
    case error(Error)
}

public final class Task<Response,Error> {
    
    // Initialization handler.
    public typealias Initializer = (_: @escaping (APIResult<Response>) -> Void) -> Void

    // The default value of maximum retry count.
    private let maximumRetryCount: Int = 10
    
    // The default value of maximum interval time(ms).
    private let maximumIntervalTime: Double = 10000.0
    
    // Result handler.
    private var response: ((APIResult<Response>) -> Void)?
    
    // Initializer handler.
    private var initializer: Initializer?

    // Retry count
    private lazy var retry: Int = 0

    // Interval time of request
    private lazy var interval: Double = 0.0
    
    // API response handler.
    @discardableResult
    public func response(_ handler: @escaping (APIResult<Response>) -> Void) -> Self {
        response = handler
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

    private func executeRequest() {
        initializer?({ result in
            switch result {
            case let .response(data):
                self.response?(APIResult.response(data))
            case let .error(data):
                self.response?(APIResult.error(data))
                self.doRetry()
            }
        })
    }
    
    // If `retry` count is one or more.
    private func doRetry() {
        if retry > maximumRetryCount {
            fatalError("The retry count is too many.\nPlease check the maximum retry count again.")
        }
        if retry > 0 {
            retry -= 1
            if interval > maximumIntervalTime {
                fatalError("The interval time is too much.\nPlease check the maximum interval time again.")
            }
            let delayTime = DispatchTime.now() + Double(Int64( interval / 1000.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.executeRequest()
            }
        }
    }

}
