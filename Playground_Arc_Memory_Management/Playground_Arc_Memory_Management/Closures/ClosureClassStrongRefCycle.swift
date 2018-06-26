//
//  ClosureClassWithStrongRefCycle.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class ClosureClassStrongRefCycle {
    
    let str : String
    
    // Note on 'lazy' *
    lazy var printStr: () -> () = { // no 'capture list' which means 'self' is captured by REFERENCE
        print("\(self.str)")
    }
    
    init(str: String) {
        self.str = str
    }
    
    deinit {
        print("ClosureClassStrongRefCycle is being deallocated")
    }
    
    
}

/*
 Note * :
 
 The 'lazy' keyword means "Instanciate this variable only when first accessed"
 This is usefull in this case considering before init 'str' is nil
 
 "The property is declared with lazy, meaning that it will not be assigned until it’s used the first time.
 This is required because it’s using self.str, which isn't available until after the initializer runs."
 
 
 
 “The lazy initializer for a global variable (also for static members of structs and enums) is run the first time that global is accessed, and is launched as `dispatch_once` to make sure that the initialization is atomic.”
 ( https://krakendev.io/blog/the-right-way-to-write-a-singleton )
 
 */
