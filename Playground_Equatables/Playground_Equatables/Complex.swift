//
//  Complex.swift
//  Playground_Equatables
//
//  Created by Romuald BROCHART on 08/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//
// Found on Base Swift ST graal

import Foundation

class Complex : Equatable, Comparable {

    
    var real: Double!
    var imaginary: Double!
    
    
    init(real: Double, imaginary: Double) {
        
        self.real = real
        self.imaginary = imaginary
    }

    
    
    // Equatable
    static func == (lhs: Complex, rhs: Complex) -> Bool {
        return ( lhs.real == rhs.real ) && ( lhs.imaginary == rhs.imaginary )
    }
    
    
    // Comparable : Protocol qui hérite de Equatable ( Donc '==' requis )
    static func < (lhs: Complex, rhs: Complex) -> Bool {
        
        let lhsAbs = sqrt( lhs.real*lhs.real + lhs.imaginary*lhs.imaginary )
        let rhsAbs = sqrt( rhs.real*rhs.real + rhs.imaginary*rhs.imaginary )

        return lhsAbs < rhsAbs
    }
    
}
