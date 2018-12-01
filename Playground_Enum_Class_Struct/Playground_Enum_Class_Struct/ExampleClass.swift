//
//  ExampleClass.swift
//  Playground_Enum_Class_Struct
//
//  Created by Romuald BROCHART on 21/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

/*
                                    III. CLASSES
 
 New enum cases CANNOT be added later in an extension. That leaves either a class or a struct.

 a class is REFERENCE typed
 this means it is used by reference :
 
 For CircleStruct :
 
 var a = CircleClass()
 a.radius = 60.0
 var b = a
 a.radius = 1000.0
 
     > a.radius == 1000.0   !!
     > b.radius == 1000.0   !!
 
 also a == b  > true
 
 
 */


class CircleClass {
    
    var radius : Float
    
    init(radius : Float) {
        self.radius = radius
    }
    
    func circonference() ->  Float {
        return self.radius * 2 * Float.pi
    }
    
}

