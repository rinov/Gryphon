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
        
        // API request
        
        API.Twitter.getTimeline()
        
        .success { response in

            // You can use `response` without nil cheking
            // The type of `response` is automatically inferred to Timeline
            print(response.count)
            print(response.date)
            print(response.contents)
            
        }
        
        .failure { error in

            // Check the reason of error
            print(error)
            
        }
        
        
    }
    
}

