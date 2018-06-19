//
//  ClassValueCycle.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

class ClassWithArrayCycle {
    
    var connexion : [ClassWithArrayCycle] = [] // Self reference is not an issue for classes (i.e. reference types)
    
    func linked( to obj : ClassWithArrayCycle ){
        connexion.append(obj)
    }
    
    
    init() {
        print("ClassWithArrayCycle is initialized")
    }
    
    deinit {
        print("ClassWithArrayCycle is being deallocated")
    }
}
