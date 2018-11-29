//
//  RawProtocol.swift
//  Playground_Protocol
//
//  Created by Romuald Brochard on 29/11/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//

import Foundation


// MARK:- REQUIREMENTS
protocol FirstProtocol {
    
    // VARS Requirements
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }

    // FUNC Requirements
    func someTypeMethod()
    func someTypeMethodWithArgsAndReturn(arg: String) -> Bool
    
}

class ConformClass: FirstProtocol{
    var mustBeSettable: Int = 0
    
    var doesNotNeedToBeSettable: Int = 0
    
    func someTypeMethod() {
        print("someTypeMethod")
    }
    
    func someTypeMethodWithArgsAndReturn(arg: String) -> Bool {
        print("someTypeMethodWithArgsAndReturn \(arg)")
        return true
    }
}
// The class has to implement all the variables / functions set in the protocol



// MARK:- OPTIONAL REQUIREMENTS
/// Note: has to be marked `@objc`
@objc protocol OptionalProtocol {
    @objc optional func someOptionalMethod(arg: String)
}

class ConformClassOptional: OptionalProtocol {
    // This method is marked as Optional so it is not mandatory to implement it
    /*
    func someOptionalMethod(arg: String) {
        print("someOptionalMethod \(arg)")
    }
     */
}
/*
 This is the case in `TableViewDelegate` for methods such as `didSelectRow(at:...)`
 
 you can `call` an optional method this way :
 
    let cco = ConformClassOptional()
    cco.someOptionalMethod?(arg: "abc")
                          ^
              optional chaining on func
 */


// MARK:-  Another example
protocol FullyNamed {
    var fullName: String { get }
}

class Person: FullyNamed {
    
    // This has to be set to be conform to `FullyNamed` protocol
    var fullName: String
    
    // Which requires an initialisation for fullName to be set
    init() {
        fullName = ""
    }
    
    init(_ name: String) {
        fullName = ""
    }
}
// This can be read as "to be conform to FullyNamed, a fullName variable must exist and has to be set"



// MARK:-  Protocols as Types
/*
    Protocol can be used as a `Type`
    It allows us to regroup several class under the same banner by forcing them to implement
    some functions and then use it when we need to access one or another
 
 */

protocol Aged {
    var age: Int { get }
}

protocol Named {
    var name: String { get }
}


class Human: Aged, Named {
    
    // variables specific to human
    var firstName: String
    var lastName: String
    var birthDate: Int
    
    var age: Int{
        get {
            return 2018 - birthDate
        }
    }
    
    var name: String{
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    init(birthDate: Int, firstName: String, lastName: String ){
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
    // Note: we could have set `age` and `name` in init, without computing the `get` method
    // But this demonstrate how we can conform to a protocol AFTERWARDS ...
    
}

class Dog: Aged, Named {
    var age: Int
    var name: String
    
    init(age: Int, name: String ){
        self.age = age
        self.name = name
    }
    // ... in this situation we set age and name in init
    
}

class Insect: Aged {
    var age: Int
    
    init(age: Int){
        self.age = age
    }
}


/*
 In a certain way this is a "reverse" subclassing:
This could have been done by making `Human` and `Animal` sublassing some class as `LivingThing` which could have a name and an age property, and overriding them
 
But when there are multiplie protocols, and that some functions requires more protocols, it doesn't work  with subclass
 
     protocol A
     protocol B
     protocol C

     class X : A, B
     class Y : B, C
     class Z : A, C
 
 Subclassing doesn't work here
 
 */


/*
 
 Protocol can be used as type. This means that we can define a function
 
     func printAge( someClass: Aged ) {
         print(someClass.age)
     }
     // We don't need to know the "real" type of `someClass` because we only need to access this method
 
 
 That also works with variables, and that is exactly what happens with Delegation !
 
 
 
 
 
    let human = Human(birthDate: 1991, firstName: "Romu", lastName: "Mu")
    let dog = Dog(age: 7, name: "Tical")
    let insect = Insect(age: 1)

    func printAge(_ living: Aged) {
        print("\(living.age)")
    }

    func wishBirthday(_ living: Aged & Named){
        print("Happy birthday \(living.name) for your \(living.age) birthday")
    }

    printAge(human)
    printAge(dog)
    printAge(insect)

    wishBirthday(human)
    wishBirthday(dog)
    // wishBirthday(insect) // ERROR - Because insect is not `NAmed` but only `Aged`

*/
