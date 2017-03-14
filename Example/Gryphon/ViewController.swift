//
//  ViewController.swift
//  Gryphon
//
//  Created by Ryo Ishikawa on 09/17/2016.
//  Copyright (c) 2016 Ryo Ishikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Example for GET method.
        API.Messages.getMessage()
            .retry(max: 3)
            .interval(milliseconds: 500)
            .response{ result in

            switch result {
            case let .response(message):
                print("Message=\(message)")
            case let .error(error):
                print("Error=\(error)")
            }

        }
        
        // Example for POST method.
        // Only catch the response that is successful.
        API.Messages.postMessage().response { result in
            
            if case let .response(statusCode) = result {
                print("StatusCode=\(statusCode)")
            }
            
        }
        
    }
    
}

