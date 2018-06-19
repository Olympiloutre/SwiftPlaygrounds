//
//  ClassWithoutArrayCycle.swift
//  Playground_Arc_Memory_Management
//
//  Created by Romuald BROCHART on 12/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

/*
 
 Use of Generics to create a new Class which will be unowned by default, therefore ARC will avoid strong retaincycle
 
 
 Note : you have to set the Generic conform to protocol 'AnyObject'
 otherwise there will be an error :
 
    "'unowned' must not be applied to non-class-bound 'T'; consider adding a protocol conformance that has a class bound"
 
 https://stackoverflow.com/questions/24102272/force-a-generic-type-parameter-to-be-a-class-type
 
 */

class Unowned<T: AnyObject> {
    unowned let value : T
    
    init( value : T ) {
        self.value = value
    }
}

class ClassWithoutArrayCycle {
    
    var connexion : [Unowned<ClassWithoutArrayCycle>] = [] // A list of object containing 'unowned' values of the same class
    
    func linked( to obj : ClassWithoutArrayCycle ){
        connexion.append(Unowned(value: obj))              // wrapping other classes objects inside 'Unowned' generic class
    }
    
    
    init() {
        print("ClassWithoutArrayCycle is initialized")
    }
    
    deinit {
        print("ClassWithoutArrayCycle is being deallocated")
    }
}
