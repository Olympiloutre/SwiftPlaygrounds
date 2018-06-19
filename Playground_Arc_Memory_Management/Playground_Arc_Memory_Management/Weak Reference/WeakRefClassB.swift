//
//  WeakRefClassB.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class WeakRefClassB {
    
    // Only one of the two ref is needed here but you can set both to weak
    // Note: Weak variable are ALWAYS optionnal !
    weak var classA : WeakRefClassA?
    
    init() {
        print("WeakRefClassB is initialized")
    }
    
    deinit {
        print("WeakRefClassB is being deallocated")
    }
}
