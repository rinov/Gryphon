//
//  ViewController.swift
//  Gryphon
//
//  Created by Ryo Ishikawa on 09/17/2016.
//  Copyright (c) 2016 Ryo Ishikawa. All rights reserved.
//

import UIKit
import Gryphon
class ViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Example for GET method
    @IBAction func getMessage(_ sender: AnyObject) {
        
        
        API.Messages.getMessage()
            .success { [weak self] response in
                self?.textView.text = "GET: SUCCESS\nMessage=\(response.result)"
            }
            .failure { [weak self] error in
                self?.textView.text = "GET: FAILED"
            }

    }
    
    // Example for POST method with option
    @IBAction func postMessage(_ sender: AnyObject) {

        API.Messages.postMessage()
            .retry(max: 5)
            .interval(milliseconds: 1000)
            .success { [weak self] response in
                self?.textView.text = "POST: SUCCESS\nMessage=\(response)"
            }
            .failure { [weak self] error in
                self?.textView.text = "POST: FAILED"
            }

    }
}

