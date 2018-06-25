//
//  ViewController.swift
//  Playground_Enum
//
//  Created by Romuald BROCHART on 15/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//
/*
                    ENUMERATIONS
 
 Sources :
 - https://www.raywenderlich.com/119881/enums-structs-and-classes-in-swift
 - https://medium.com/@abhimuralidharan/enums-in-swift-9d792b728835
 
 
 The objective of this tutorial is to:
 
 Give you some experience using enums, structs and classes.
 Gain some intuition about when to use them.
 Give you an understanding of how each works.
 
 
 
 
                               SWIFT TYPE SYSTEM

                                     TYPES
                                 ↙          ↘
                        NAMED                  COMPOUND
                  ↙    ↓    ↓   ↘                   ↙     ↘
           protocol struct enum class             tuples function
                    |---------------|
                      model types
 
 
 Note: all models can adopt protocol, even enum's
 
     
       I. ENUMS
      II. STRUCT ( part* )
     III. CLASS  ( part* )
 
 
 Note* : this tut is essentially to learn about enums, class and struct are just reminders here.
 
 */





import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK:- I. ENUMS
        // -> go to ExampleEnums
        print("--- Simple Color Named ---")
        print(SimpleColorName.black)            // > "black"
        print(SimpleColorName.black.hashValue)  // > 0
        
        print("--- Simple Color Int ---")
        print(SimpleColorInt.black)           // > "black"
        print(SimpleColorInt.black.hashValue) // > 0
        print(SimpleColorInt.black.rawValue)  // > 100
        print(SimpleColorInt.black.description()) // > "(func) rawValue = 100 | hashValue = 0"
        print(SimpleColorInt.black.desc)          // >  "(var) rawValue = 100 | hashValue = 0"
        
        print("--- AssociatedValues Enums---")
        print(SimpleAssociatedValueEnum.associatedInt(5))            // > "associatedInt(5)"
        print(SimpleAssociatedValueEnum.associatedInt(5).desc)       // > (Associated Int) 5
        print(SimpleAssociatedValueEnum.associatedDouble(6.0).desc)  // > (Associated Double) 6.0
        print(SimpleAssociatedValueEnum.associatedString("7s").desc) // > (Associated String) 7s
        
        print("--- MyColor Example ---")
        print(MyColors.rgb(125,100,88).toHEX)   // > "#7d6458"
        
        print("--- Multiple result types Example ---")
        print(MyMathLib.squareRoot(4).desc) // "The result of the operation is 2.0"
        print(MyMathLib.squareRoot(-1).desc) // "An error occured while computing operation : Cannot calculate the squareRoot of a non-positive double"
        
        print("--- My Option Example ---")
        print(MyOptional.some(Double(6)).desc)
        // cannot write 'MyOptional.none.desc' -> we have to set the Generic Type
        print(MyOptional<Double>.none.desc)
        
        
        
        
        // MARK:- II. STRUCT
        // -> go to ExampleStruct
        print("--- Circle Struct Example ---")
        var a = CircleStruct(radius: 60.0)
        var b = a
        a.radius = 1000.0
        print(a.radius) // > 1000.0
        print(b.radius) // >   60.0
        
        
        
        
        // MARK:- III. CLASS
        // -> go to ExampleClass
        print("--- Circle Class Example ---")
        var c = CircleClass(radius: 60.0)
        var d = c
        c.radius = 1000.0
        print(c.radius) // > 1000.0
        print(d.radius) // > 1000.0
        
        

    }

}




