//
//  ClosureClassWeakReference.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation
//
//  ClosureClassUnownedReference.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class ClosureClassWeakReference {
    
    let str : String
    
    
    /*
     Note on 'lazy' * ( cf 'ClosureClassStrongRefCycle' )
     
     This adds [weak self] to the capture list for the closure.
     It means that self is captured as an weak reference instead of a strong reference.
     
     "a new self variable is created which shadows the existing self variable just for the closure’s scope." ( + is 'weak' )
     
     */
    lazy var printStr: () -> () = { [weak self] in // Weak copy of self inside printStr
        // As a weak object is always optionnal, so the 'weak' copy of self is also optional in this scope
        //           ↓
        print("\(self?.str)") 
    }
    
    
    init(str: String) {
        self.str = str
    }
    
    deinit {
        print("ClosureClassWeakReference is being deallocated")
    }
    
    
}
