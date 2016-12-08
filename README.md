# Gryphon (REST API kit for Swift)

[![CI Status](https://travis-ci.org/rinov/Gryphon.svg?branch=master)](https://travis-ci.org/rinov/Gryphon.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/Gryphon.svg?style=flat)](http://cocoapods.org/pods/Gryphon)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
[![Language](https://img.shields.io/badge/Language-Swift2.3-blue.svg)](https://img.shields.io/badge/Language-Swift2.3-blue.svg)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg)](https://img.shields.io/badge/LICENSE-MIT-yellow.svg)

Gryphon is a REST API kit that's type safe and convenient for Swift :yum:

[![Figure](http://i.imgur.com/i8Yqt8g.png)](http://i.imgur.com/i8Yqt8g.png)

```swift

API.Endpoint.request()
        .retry(max: 3)
        .interval(milliseconds: 500)
        
        .success { response in
            // Do something
        }
        
        .failure { error in
            // Do someting 
        }

```


### How to use this?:eyes: (Example for retrieving from Twitter API)

First of all, Create an API class.

e.g.

```swift

final class API {
    
    ....
    
}

```

Next step , Implement your request in compliance with `Requestable` protocol.

e.g. using `Alamofire`

```swift

extension API {

    final class Twitter: Requestable {

        enum Router: String {
        
            case status = "/status/"
            // ... and so on
            
        }
        
        var router: Router = .status
            
        // required `Requestable`
        static var baseURL: String {
            
            return "https://api.twitter.com/1.1/statuses/"
            
        }

        // required `Requestable`
        static var path: String {
            
            return baseURL + router.rawValue
            
        }
        
        // `Any` in TaskType is your Response class.
        static func getTimeline() -> TaskType< Any, ErrorType> {
            
            // Switching the router
            router = .status
            
            let task = TaskType { success, failure in
                
                Alamofire.request(.POST, path)
                    .responseJSON(completionHandler: { response in

                        // Object mapping in your favorite way.

                        // If the mapping is succeed.
                        if yourOwnCheck {
                            
                            success(response)
                            
                        }else{
                            
                            failure(ResponseError.unexceptedResponse("Cause(String) or AnyObject is available."))
                            
                        }
                        
                    })
                
            }
            
            return task
            
        }
        
    }
    
}

```

After that you can use it like this.

```swift

API.Twitter.getTimeline()
        
        // It will retry the API request if that is timeout or failed.
        .retry(max: 3)
        
        // Specify the interval time of retry.
        .interval(milliseconds: 500)
        
        // If the response is valid, This will be called.
        .success { response in

            /*
            * You can use `response` without nil checking.
            * The type of `response` is automatically inferred to your Response class.
            * e.g. your Model class is `Timeline`
            */
            
            let timeline: Timeline = response // This is ok because response is NOT optional type
            print(response.count) // this is ok because response have already object mapping
            
        }
        
        // If the response is INVALID, This will be called.
        .failure { error in

            // Check the reason of error
            print(error)
            
        }

```

## Requirements

Swift3.0

iOS8+

## Installation

In your Podfile:

```ruby
use_frameworks!

target 'YOUR_TARGET_NAME' do
  pod 'Gryphon'
end

```
and

`$ pod install`

## License

`Gryphon` is released under the MIT license.

https://github.com/rinov/Gryphon/blob/master/LICENSE
