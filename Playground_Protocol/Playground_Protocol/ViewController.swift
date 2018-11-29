//
//  ViewController.swift
//  Playground_Protocol
//
//  Created by Romuald Brochard on 29/11/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//
/*
 
.                        Playground on Protocols
 
 
 Sources :
 - https://docs.swift.org/swift-book/LanguageGuide/Protocols.html
 - BArtenderMacApp
 
 */

import UIKit

class ViewController: UIViewController {

    var customView = CustomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCustomViewt()
        mainForRawProtocol()
    }
    
    
    // MARK:- RAW PROTOCOL EXAMPLES
    func mainForRawProtocol() {
        let human = Human(birthDate: 1991, firstName: "Romu", lastName: "Mu")
        let dog = Dog(age: 7, name: "Tical")
        let insect = Insect(age: 1)
        
        func printAge(_ living: Aged) {
            print("\(living.age)")
        }
        
        func wishBirthday(_ living: Aged & Named){
            print("Happy birthday \(living.name) for your \(living.age) birthday")
        }
        
        printAge(human)
        printAge(dog)
        printAge(insect)
        
        wishBirthday(human)
        wishBirthday(dog)
        // wishBirthday(insect) // ERROR - Because insect is not `NAmed` but only `Aged`
        
    }
    
    
    // MARK:- DELEGATION EXAMPLE
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
        /// This is mainly used to implement actions in current Viewcontroller (or class) on actions of a class defined elsewhere
        view.backgroundColor = .black
    }
}
