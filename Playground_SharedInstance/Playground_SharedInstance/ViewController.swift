//
//  ViewController.swift
//  Playground_SharedInstance
//
//  Created by Romuald BROCHART on 25/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

/*
                            SINGLETON - SHARED INSTANCE
 
 
 sources :
 - https://krakendev.io/blog/the-right-way-to-write-a-singleton
 

 This is an example of a SharedInstance/Singleton. Pretty simple this ones
 
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Accessing :
        print("my singleton param : \(MySingleton.sharedInstance.param)")
        MySingleton.sharedInstance.param = "modified"
        print("my singleton param : \(MySingleton.sharedInstance.param)")

        // Accessible wherever we are in the app
    }

}

