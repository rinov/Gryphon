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
        
        // Example for GET method

        _ = API.Messages.getMessage()
            .retry(max: 5)
            .interval(milliseconds: 1000)
        
            .success { response in

                print("GET success!")
                print("Message=\(response.result)")
                
            }

            .failure { error in

                print("GET Error!")
                
            }
        
        // Example for POST method
        
        _ = API.Messages.postMessage()

            .success { response in
                
                print("POST success!")
                print("Status code=\(response)")
                
            }
            
            .failure { error in
                
                print("POST Error!")
                
            }
        
    }
    
}

