//
//  ClosureClass.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class SimpleClass {
    
    let str : String
    
    init(str: String) {
        self.str = str
    }

    deinit {
        print("SimpleClass is being deallocated")
    }
}
