# Gryphon (REST API kit for Swift)

[![CI Status](https://travis-ci.org/rinov/Gryphon.svg?branch=master)](https://travis-ci.org/rinov/Gryphon.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/Gryphon.svg?style=flat)](http://cocoapods.org/pods/Gryphon)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
[![Language](https://img.shields.io/badge/Language-Swift%203.0%20and%202.3%20are%20compatible-blue.svg)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg)](https://img.shields.io/badge/LICENSE-MIT-yellow.svg)

Gryphon is a REST API kit that's type safe and convenient for Swift :yum:

[![Figure](http://i.imgur.com/i8Yqt8g.png)](http://i.imgur.com/i8Yqt8g.png)

### Usage
```swift

```swift
API
    .Messages
    .getMessage()
    .retry(max: 3) // It will retry the API request if that is timeout or failed.
    .interval(milliseconds: 500) // Specify the interval time of retry.
    .response{ result in
        /*
        * You can use `result` without nil checking.
        * The type of `result` is automatically inferred to your designation type.
        * e.g. This case of `result` is a type of `String`
        */

        switch result {
        case let .response(message):
            // Do something
        case let .error(error):
            // Do something
        }
    }
```


### How to use this?:eyes:

First of all, Create an API class.

e.g.

```swift

final class API {
    ....
}

```

Next step , Implement your request in compliance with `Requestable` protocol.

e.g.

```swift
extension API {
    final class Messages: Requestable {
    
    // required `Requestable`
    static var baseURL: String {
        return "http://rinov.jp/"
    }

    // required `Requestable`
    static var path: String {
        return "Gryphon-Tutorial.php"
    }

    // Returns message(String) from server or error reason(Error).
    class func getMessage() -> Task<String, Error> {
        let task = Task<String, Error> { result in
            let url = URL(string: baseURL + path)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let session = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject],
                    let message = json?[0]["result"] as? String else {
                        result(.error(ResponseError.unexceptedResponse(error as AnyObject)))
                        return
                }
                result(.response(message))
            })
            session.resume()
            }
            return task
        }
    }
}
```

After that you can use it like this.

```swift

API
    .Messages
    .getMessage()
    .retry(max: 3) // It will retry the API request if that is timeout or failed.
    .interval(milliseconds: 500) // Specify the interval time of retry.
    .response{ result in
        switch result {
        case let .response(message):
            // Do something
        case let .error(error):
            // Do something
        }
    }
```

## Requirements

Swift4
XCode9

## Installation

In your Podfile:

```ruby
use_frameworks!

target 'YOUR_TARGET_NAME' do
  pod 'Gryphon', '~> 3.1'
end
```

and

`$ pod install`

## License

`Gryphon` is released under the MIT license.

https://github.com/rinov/Gryphon/blob/master/LICENSE
