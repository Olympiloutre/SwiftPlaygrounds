//
//  CustomView.swift
//  Playground_Protocol
//
//  Created by Romuald Brochard on 29/11/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//
/*
 
 
.                       DELEGATION
 
 This is an empty UIView with a click gesture recognizer
 This shows how to compute protocol as method delegation
 
 Delegation is basically as if we had set a closure such as :
 
    var action: (() -> ())?
 
 and then defined the action method in the CustomView declaration
 
    let custom = CustomView()
    custom.action = { ... do my stuff ... }
    // constraints & stuff
 
 
 */

import UIKit

//1. Defining a protocol
/// Generally this is a bunch of function a class must implement in order to be `conform to this protocol`
protocol CustomViewDelegate {
    func actionOnClickLabel()
}

class CustomView: UIView {

    var label = UILabel()
    
    // 2. referencing a variable for an eventual delegate
    var delegate: CustomViewDelegate?
    /// This will be set in the CustomView's object setup method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .red
        setup()
    }
    
    func setup() {
        label.text = "My Custom View"
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }
    
    @objc func handleTap() {
        print("Tapped Label")
        // 3. Calling the delegate's implemented method, if a delegate was set
        delegate?.actionOnClickLabel()
    }
}
