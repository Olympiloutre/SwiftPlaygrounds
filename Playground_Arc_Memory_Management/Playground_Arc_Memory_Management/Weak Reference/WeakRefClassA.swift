//
//  WeakRefClassA.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class WeakRefClassA {
    
    var classB : WeakRefClassB?
    
    init() {
        print("WeakRefClassA is initialized")
    }
    
    deinit {
        print("WeakRefClassA is being deallocated")
    }
}
