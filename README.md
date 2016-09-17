# Gryphon

[![CI Status](https://travis-ci.org/rinov/Gryphon.svg?branch=master)](https://travis-ci.org/rinov/Gryphon.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/Gryphon.svg?style=flat)](http://cocoapods.org/pods/Gryphon)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift2.2+

iOS8+

## Installation

Gryphon is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Gryphon"
```

## How to use this

### Preparing

```
// Response model
final class Timeline {
    
    var count: Int!
    
    var date: NSDate!
    
    var contents: [String]!
    
}

```

### Defination

First of all, create your API class.

```

final class API {
    
    let proxy = "http://"
    
    let version = "v1"
    
}

```

Next step , implement your request.

```

extension API {

    final class Twitter: Requestable {

        //Endpoint information
        static let url = "https://api.twitter.com/1.1/statuses/"
        
        //Requestable protocol
        static var headerFields: [String: String] {
            
            // Customize your header
            return [:]
        
        }
        
        static var path: String {

            return baseURL + router.rawValue
            
        }
        
        //Task type. `Task<ResponseType,ErrorType>`
        typealias TaskType = Task<Timeline,ErrorType>
        
        
        //API request
        
        static func getTimeline() -> TaskType {
            
            let task: TaskType = TaskType { success, failure in
                
                Alamofire.request(.POST, path)
                    .responseJSON(completionHandler: { response in

                        let yourOwnCheck = true
                        
                        if yourOwnCheck {
                            
                            let timeline = Timeline()
                            
                            // Object mapping in your favorite way
                            
                            success(timeline)
                            
                        }else{
                            
                            failure(ResponseError.unexceptedResponse(response.result.value ?? ""))
                            
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

            // You can use `response` without nil checking
            // The type of `response` is automatically inferred to Timeline
            print(response.count)
            print(response.date)
            print(response.contents)
            
        }
        
        .failure { error in

            // Check the reason of error
            print(error)
            
        }

```

## Coming soon

`Retry`

`Progress`

`Delay`

## License

Apache License 2.0

https://github.com/rinov/Gryphon/blob/master/LICENSE
