//
//  ClassWithGenerics.swift
//  Playground_Generics
//
//  Created by Romuald BROCHART on 08/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation


/*
 Class with generic types
 
 Basically it looks much alike an Array or Dic

 Note : as in function you can put a restriction on the generic type ( Equatable etc... )
 */
class ClassWithGenerics <GenericType> {
    
    var elements : [GenericType] = []
    
    // Append an item to list
    func add(_ item : GenericType ){
        
        self.elements.append(item)
    }
    
    // Extract first item and return it. nil if no items
    func dequeu() -> GenericType?{
        
        guard !elements.isEmpty else { return nil }
        return elements.remove(at: 0)
    }
    
}


/*
 Class with generic types with a constraint
 
 It is possible to set a restriction to a generic type.
 The 'Constraint' is a conformance to a specific protocol
 
 Here the generic type is conform to the Numeric protocol, this is for us to use functions defined inside it
 
 */
class ClassWithGenericsConstraint <GenericConstraintType: Numeric> {
    
    var elements : [GenericConstraintType] = []
    
    func sum() -> GenericConstraintType{
        var sum: GenericConstraintType = 0
        for element in elements {
            sum += element // Without the conformance to this protocol, you cannot use '+' 
        }
        return sum
        
       // return elements.reduce(0, +) would have worked too
    }
}


/*
 We can also extend a class with generics for a special kind of object
 
 For that purpose we use the keyword 'where'
 
 For istances of 'ClassWithGenerics' where 'GenericType' is not numeric, the function is not accessible
 */
extension ClassWithGenerics where GenericType: Numeric {
    func sum() -> GenericType {
        return elements.reduce(0, +)
    }
}


/*
 Another main example
 */
extension Sequence where Element: Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}


/*
 Finally you can ever compute an extension for a specific kind of object, with 'where' and '=='
 */
extension ClassWithGenerics where GenericType == String {
    func concat() -> GenericType { // or -> String
        return elements.reduce(""){ concat, string in
            return concat + " " + string
        }
    }
}

