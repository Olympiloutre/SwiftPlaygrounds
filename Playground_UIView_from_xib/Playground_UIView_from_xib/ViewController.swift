//
// ViewController.swift 
//
// Created by Qantas Dev on 5/9/19
// Copyright © 2019 Romuald Brochard. All rights reserved.
//
// Sources :
// - https://medium.com/better-programming/swift-3-creating-a-custom-view-from-a-xib-ecdfe5b3a960

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.titleLabel.text = "Hello World"
    }
}

