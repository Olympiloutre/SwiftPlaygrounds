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
