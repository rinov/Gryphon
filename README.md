# Gryphon

[![CI Status](https://travis-ci.org/rinov/Gryphon.svg?branch=master)](https://travis-ci.org/rinov/Gryphon.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/Gryphon.svg?style=flat)](http://cocoapods.org/pods/Gryphon)
[![Dependencies](https://img.shields.io/badge/dependencies-Alamofire-red.svg)](https://img.shields.io/badge/dependencies-Alamofire-red.svg)
[![Platform](https://img.shields.io/badge/platform-iOS-brightgreen.svg)](https://img.shields.io/badge/platform-iOS-brightgreen.svg)
[![Language](https://img.shields.io/badge/Language-Swift-blue.svg)](https://img.shields.io/badge/Language-Swift-blue.svg)

Gryphon is an HTTP client using Alamofire that's type safe and convenient.

```
API.Endpoint.request()
        
        .success { response in
            // Do something
        }
        
        .failure { error in
            // Do someting 
        }

```


### How to use this? (Example for retrieving from Twitter API)

First of all, Create a API class for proxy pattern.

e.g.

```

class API {
    
    let baseURL = "https://api.twitter.com/"
    
    let version = "1.1"
    
    ....
    
}

```

Next step , Implement functional class.

```

extension API {

    class Twitter: Requestable {

        enum Router {
        
            case status = "/status/"
            // ... and so on
            
        }
        
        var route: Router = .status // Default value of this endpoint
            
        // Requestable protocol(Required)
        static var headerFields: [String: String] {
            
            // Customize your header
            return [:]
        
        }

        // Requestable protocol(Required)
        static var path: String {

            return baseURL + "/" + version + "/" + router.rawValue
            
        }
        
        /*  API request
         *  `ResponseType` is your own Model class
         */
        static func getTimeline() -> TaskType< ResponseType, ErrorType> {
            
            let task: TaskType = TaskType { success, failure in
                
                Alamofire.request(.POST, path)
                    .responseJSON(completionHandler: { response in

                        // Object mapping in your favorite way

                        // If the mapping is succeed
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

```

API.Twitter.getTimeline()
        
        .success { response in

            /*
            * You can use `response` without nil checking.
            * The type of `response` is automatically inferred to your Model class.
            * e.g. your Model class is `Timeline`
            */
            
            let timeline: Timeline = response // This is ok because response is NOT optional type
            print(response.count) // this is ok because response have already object mapping
            
        }
        
        .failure { error in

            // Check the reason of error
            print(error)
            
        }

```

## TODO

`Retry`

`Progress`

`Cancel`

`Delay`

## Requirements

Swift2.2+

iOS8+

Alamofire 3.x

## Installation

In your Podfile:

```ruby
pod "Gryphon"
```
and

`pod install`

## License

Apache License 2.0

https://github.com/rinov/Gryphon/blob/master/LICENSE
