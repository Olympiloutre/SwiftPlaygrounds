//
//  ViewController.swift
//  Playground_Protocol
//
//  Created by Romuald Brochard on 29/11/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//
/*
 
.                        Playground on Protocols
 
 */

import UIKit

class ViewController: UIViewController {

    var customView = CustomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCustomViewt()
    }

    func setupCustomViewt() {
        
        // (has begun in CustomView.swift)
        // 4. settings the delegate for `customView` to self
        customView.delegate = self
        /// this implies that this `ViewController` Class HAS TO conform to this protocol
        
        view.addSubview(customView)
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        customView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        customView.heightAnchor.constraint(equalTo: customView.widthAnchor).isActive = true

    }

}

// 5. Protocol conformance in Extensions by convention
extension ViewController: CustomViewDelegate {
    
    // 6. have to set this method in order to be conform to the protocol ( otherwise error )
    func actionOnClickLabel() {
        print("Called from delegate")
        
        /// everything in here will be called when `delegate?.actionOnClickLabel()` is called in `customView`
        /// This also allows us to access `ViewController` properties : e.g. view
        view.backgroundColor = .black
    }
}
