//
//  ViewController.swift
//  Playground_Dependency_Injection_Basis
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//
/*
 
 from : https://theswiftdev.com/2018/07/17/swift-dependency-injection-design-pattern/
 
 
                DEPENDENCY INJECTION PATTERN
 
    "Dependency injection means giving an object its instance variables. Really. That's it."
 
 This is done via PROTOCOL.
 e.g. You define a variable as a protocol `var service: MyService` where MyService is a protocol
 
 On this playground we will youse the ENCODE protocol
 
 
     protocol Encoder {
        func encode<T>(_ value: T) throws -> Data where T: Encodable
     }
     extension JSONEncoder: Encoder { }
     extension PropertyListEncoder: Encoder { }
 
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

