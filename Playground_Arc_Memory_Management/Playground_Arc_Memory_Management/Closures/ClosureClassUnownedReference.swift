//
//  ClosureClassUnownedReference.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class ClosureClassUnownedReference {
    
    let str : String
    
    
    /*
     Note on 'lazy' * ( cf 'ClosureClassStrongRefCycle' )
     
     This adds [unowned self] to the capture list for the closure.
     It means that self is captured as an unowned reference instead of a strong reference.
     
     "a new self variable is created which shadows the existing self variable just for the closure’s scope." ( + is unowned )
     
     */
    lazy var printStr: () -> () = { [unowned self] in // Unowned copy of self inside printStr
        print("\(self.str)")
    }

    
    init(str: String) {
        self.str = str
    }
    
    deinit {
        print("ClosureClassUnownedReference is being deallocated")
    }
    
    
}
