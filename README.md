# Gryphon (REST API kit for Swift2.3+)

[![CI Status](https://travis-ci.org/rinov/Gryphon.svg?branch=master)](https://travis-ci.org/rinov/Gryphon.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/Gryphon.svg?style=flat)](http://cocoapods.org/pods/Gryphon)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
[![Language](https://img.shields.io/badge/Language-Swift%203.0%20and%202.3%20are%20compatible-blue.svg)](https://img.shields.io/badge/Language-Swift%203.0%20and%202.3%20are%20compatible-blue.svg)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg)](https://img.shields.io/badge/LICENSE-MIT-yellow.svg)

Gryphon is a REST API kit that's type safe and convenient for Swift2.3+ :yum:

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


### How to use this?:eyes: (Example for retrieving a message)

Example of endpoint:

Sending request to `http://rinov.jp/Gryphon-Tutorial` by `GET` will return

```json
[
    {
        "result": "Hello World!"
    }
]
```

Sending request to `http://rinov.jp/Gryphon-Tutorial` by `POST` will return

```json
[
    {
        "result": "Sent a message"
    }
]
```

First of all, Create an API class.

e.g.

```swift

final class API {
    
    ....
    
}

```

Next step , Implement your request in compliance with `Requestable` protocol.

e.g. Using [Alamofire](https://github.com/Alamofire/Alamofire) with swift3.0.

```swift

extension API {

  final class Messages: Requestable {
        
        // required `Requestable`.
        static var baseURL: String {
            
            return "http://rinov.jp/"
            
        }

        // required `Requestable`.
        static var path: String {
            
            return baseURL + "Gryphon-Tutorial.php"
            
        }
        
        class func getMessage() -> Task<Message, Error> {
            
            let task = Task<Message, Error> { success, failure in
                
                Alamofire.request(path, method: .get, encoding: JSONEncoding.default)
                    .responseJSON(completionHandler: { response in

                        // Object mapping in your favorite way.
                        let result = (response.result.value as! [AnyObject])[0]["result"] as! String

                        let yourOwnCheck = true
                        
                        if yourOwnCheck {
                            
                            let message = Message(message: result)

                            success(message)
                            
                        }else{
                            
                            let reason = response.result.description as AnyObject
                            failure(ResponseError.unexceptedResponse(reason))
                            
                        }
                        
                    })
                
            }
            
            return task
            
        }
        
        class func postMessage() -> Task<Int, Error> {
            
            let task = Task<Int, Error> { success, failure in

                Alamofire.request(path, method: .post, encoding: JSONEncoding.default)
                    .responseJSON(completionHandler: { response in
                     
                        let yourOwnCheck = true
                        
                        if yourOwnCheck {
                            
                            success(response.response?.statusCode ?? 0)
                            
                        }else{
                            
                            let reason = response.result.description as AnyObject
                            failure(ResponseError.unexceptedResponse(reason))
                            
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

API.Messages.getMessage()
        
        // It will retry the request if that is timeout or failed.
        .retry(max: 3)
        
        // Specify the interval time of retry.
        .interval(milliseconds: 500)
        
        // If the response is valid, This will be called.
        .success { response in

            /*
            * You can use `response` without nil checking.
            * The type of `response` is automatically inferred to your Response class.
            * e.g. your Model class is `Message`
            */
            
            let message: Message = response // This is ok because response is NOT optional type.
            print(response.result) // This is ok because response has already object mapping.
            
        }
        
        // If the response is INVALID, this will be called.
        .failure { error in

            // Check the reason of error.
            print(error)
            
        }

```

## Requirements

Swift2.3(iOS8+) or Swift3.0(iOS9+)

## Installation

## Swift2.3

In your Podfile:

```ruby
platform :ios,'8.0'
use_frameworks!

target 'YOUR_TARGET_NAME' do
  pod 'Gryphon', '~> 1.0'
end

```
and

`$ pod install`

## Swift3.0

In your Podfile:

```ruby
platform :ios,'10.0'
use_frameworks!

target 'YOUR_TARGET_NAME' do
  pod 'Gryphon', '~> 2.0'
end

```
and

`$ pod install`
> CocoaPods 1.1.0+ is required to build Gryphon 2.0.0+.

## License

`Gryphon` is released under the MIT license.

https://github.com/rinov/Gryphon/blob/master/LICENSE
