//
//  StrongRefClassA.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class StrongRefClassA {
    
    var classB : StrongRefClassB?
    
    init() {
        print("StrongRefClassA is initialized")
    }
    
    deinit {
        print("StrongRefClassA is being deallocated")
    }
    
}

