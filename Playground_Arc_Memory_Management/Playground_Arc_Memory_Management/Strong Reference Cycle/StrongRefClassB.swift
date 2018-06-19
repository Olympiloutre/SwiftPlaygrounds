//
//  StrongRefClassB.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class StrongRefClassB {
    
    var classA : StrongRefClassA?

    init() {
        print("StrongRefClassB is initialized")
    }
    
    deinit {
        print("StrongRefClassB is being deallocated")
    }
}
