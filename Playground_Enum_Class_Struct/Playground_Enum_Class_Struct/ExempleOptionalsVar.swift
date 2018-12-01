//
//  ExempleOptionalsVar.swift
//  Playground_Enum_Class_Struct
//
//  Created by Romuald Brochard on 01/12/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation


class OptionalRemiders {
    
    // Not optiona variable -> Requires an init to be set
    /// "Class 'OptionalRemiders' has no initializers"
    var nonOptionalVariable: Int
    /// Init can be avoided by providing a default value
    /// e.g. `var nonOptionalVariable: Int = 0`
    
    
    // Optional Variable -> Does not requires an init
    /// If accessed and not set, returns `nil`
    var optionalVariable: Int?
    
    // Optional Variable Unwrapped -> Does not requires an init
    /// If accessed and not set, crash
    var unwrappedOptionalVariable: Int!
    
    
    // Init required to set non optional var
    init() {
        nonOptionalVariable = 0
    }
    
}

/// Note: for non optional vars, if you are in Struct, you don't need to implement `init` because init is provided by default according to all it's variables 
