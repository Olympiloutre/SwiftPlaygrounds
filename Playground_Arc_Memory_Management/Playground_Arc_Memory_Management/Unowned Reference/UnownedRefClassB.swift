//
//  UnownedRefClassB.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class UnownedRefClassB {
    
    // Note: Unowned variable are NEVER optionnal !..
    unowned var classA : UnownedRefClassA
    
    // ...And as it is not optionnal we need to define init
    init(classA : UnownedRefClassA) {
        self.classA = classA
        
        print("UnownedRefClassB is initialized")
    }
    
    deinit {
        print("UnownedRefClassB is being deallocated")
    }
}
