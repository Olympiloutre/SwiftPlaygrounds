//
// LiskovSubstitutionPrinciple.swift 
//
// Created by Qantas Dev on 16/5/19
// Copyright © 2019 Romuald Brochard. All rights reserved.
// https://marcosantadev.com/solid-principles-applied-swift/
//
//
// The Liskov Substitution Principle (LSP)
// FUNCTIONS THAT USE POINTERS OR REFERENCES TO BASE CLASSES MUST BE ABLE TO USE OBJECTS OF DERIVED CLASSES WITHOUT KNOWING IT.

import Foundation

// MARK:- Preconditions changes

class WrongHandlerLSP {
    
    func save(string: String) {
        // Save string in the Cloud
    }
}

class WrongFilteredHandler: WrongHandlerLSP {
    
    override func save(string: String) {
        guard string.count > 5 else { return } // break LSP
        
        super.save(string: string)
    }
}

// This example breaks LSP because, in the subclass, we add the precondition that string must have a length greater than 5. A client of Handler doesn’t expect that FilteredHandler has a different precondition, since it should be the same for Handler and all its subclasses.
// Correct

class HandlerLSP {
    
    func save(string: String, minChars: Int = 0) {
        guard string.count >= minChars else { return }
        
        // Save string in the Cloud
    }
}

class FilteredHandler: HandlerLSP {
    
    func save(string: String) {
        super.save(string: string, minChars: 5)
    }
}




// MARK:- Postconditions changes

class WrongRectangle {
    
    var width: Float = 0
    var length: Float = 0
    
    var area: Float {
        return width * length
    }
}

class WrongSquare: WrongRectangle {
    
    override var width: Float {
        didSet {
            length = width
        }
    }
}

// With this approach, we break LSP because if the client has the current method:

/*
func wrongMain {
    
    func printArea(of rectangle: Rectangle) {
        rectangle.length = 5
        rectangle.width = 2
        print(rectangle.area)
    }
    
    // the result should always be the same in the both calls:
    
    let wrongRectangle = WrongRectangle()
    printArea(of: wrongRectangle) // 10
    
    // -------------------------------
    
    let wrongSquare = WrongSquare()
    printArea(of: wrongSquare) // 4
    
}
*/

// Correction with Protocol

protocol Polygon {
    var area: Float { get }
}

class Rectangle: Polygon {
    
    private let width: Float
    private let length: Float
    
    init(width: Float, length: Float) {
        self.width = width
        self.length = length
    }
    
    var area: Float {
        return width * length
    }
}

class Square: Polygon {
    
    private let side: Float
    
    init(side: Float) {
        self.side = side
    }
    
    var area: Float {
        return pow(side, 2)
    }
}


/*
// Client Method

func printArea(of polygon: Polygon) {
    print(polygon.area)
}

// Usage

let rectangle = Rectangle(width: 2, length: 5)
printArea(of: rectangle) // 10

let square = Square(side: 2)
printArea(of: square) // 4
*/
