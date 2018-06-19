//
//  UnownedRefClassA.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class UnownedRefClassA {
    
    var classB : UnownedRefClassB?
    
    init() {
        print("UnownedRefClassA is initialized")
    }
    
    deinit {
        print("UnownedRefClassA is being deallocated")
    }
    
}
