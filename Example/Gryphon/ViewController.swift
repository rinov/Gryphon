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
        
        API.Twitter.getTimeline()
            .retry(max: 11)
            .interval(milliseconds: 500)
        
            .success { response in

                print("success")
                
            }
            
            .failure { error in

                print("error")
                
            }
        
        
    }
    
}

