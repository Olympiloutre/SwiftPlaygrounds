//
//  ExampleEnums.swift
//  Playground_Enum_Class_Struct
//
//  Created by Romuald BROCHART on 21/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation

/*
                                    I. ENUMS
 
 "An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code."
    > https://medium.com/@abhimuralidharan/enums-in-swift-9d792b728835
    > https://www.tutorialspoint.com/swift/swift_enumerations.htm
    > (https://www.raywenderlich.com/130197/magical-error-handling-swift)
 
 This is an elegant way to restrict usage of specific values inside the code
 
 New enum cases CANNOT be added later in an extension. That leaves either a class or a struct.
 
 This will also be really helpfull for error handling
 
 */



/*
                                    a. Enums Without type
 
 SimpleColorName.grey // ERROR
 SimpleColorName.gray // OK (restriction)
 
 
 Without specifying any type in the Enum, it is only caracterized by it's HashValue, which is basically an index
 
 
 print(SimpleColorName.black)           > "black"
 print(SimpleColorName.black.hashValue) > 0
 
 */

enum SimpleColorName {
    case black
    case silver
    case gray
    case white
    case maroon
    case red
}



/*
                                    b. RawValue Enums
 
 We can set a type for an enum, this is called a RawValue, which become accessible in later code
 
 "Enumerations that explicitly specify a backing store type are referred to as RawRepresentable, because they automatically adopt the RawRepresentable protocol."
 
 
 print(SimpleColorInt.black)            > "black"
 print(SimpleColorInt.black.hashValue)  > 0
 print(SimpleColorInt.black.rawValue)   > 100
 
 
 
 Note : for the previous one, trying to access RawValue will throw an error
         > print(SimpleColorName.black.rawValue)  // ERROR NO MEMBER
 
 
 
 + We can also set methods and vars inside an enum :

 print(SimpleColorInt.black.description()) // > "(func) rawValue = 100 | hashValue = 0"
 print(SimpleColorInt.black.desc)          // >  "(var) rawValue = 100 | hashValue = 0"

 */

enum SimpleColorInt : Int {
    case black  = 100
    case silver = 101
    case gray   = 102
    case white  = 103
    case maroon = 104
    case red    = 105
    
    
    func description() -> String {
        return "rawValue = \(self.rawValue) | hashValue = \(self.hashValue)"
    }
    
    var desc : String {
        get {
            return "rawValue = \(self.rawValue) | hashValue = \(self.hashValue)"
        }
    }
}


/*
                                    c. AssociatedValues Enums
 
 Sincerely the most usefull Enum type. It allows us to pass different value type inside a single Enum.
 This is really usefull to wrap an answer inside two different type, for instance when we want to manage errors.
 
 
 To access it, you use the 'let' token, to make it accessible inside the bracelet
 
 
 print(SimpleAssociatedValueEnum.associatedInt(5))            // > "associatedInt(5)"
 print(SimpleAssociatedValueEnum.associatedInt(5).desc)       // > (Associated Int) 5
 print(SimpleAssociatedValueEnum.associatedDouble(6.0).desc)  // > (Associated Double) 6.0
 print(SimpleAssociatedValueEnum.associatedString("7s").desc) // > (Associated String) 7s
 
 
 
 
 NOTE : AssociatedValues Enum do not have rawValue and hashValue member (logic...) !
 SimpleAssociatedValueEnum.associatedDouble(6.0).hashValue // ERROR - no member hashValue
 SimpleAssociatedValueEnum.associatedDouble(6.0).rawValue  // ERROR - no member rawValue

 
 */

enum SimpleAssociatedValueEnum {
    
    case associatedInt(Int)
    case associatedDouble(Double)
    case associatedString(String)
    
    var desc : String {
        get {
            switch self {
            case .associatedInt(let theInt) :
                let s = "(Associated Int) \(theInt)"
                return s
            case .associatedDouble(let theDouble) :
                let s = "(Associated Double) \(theDouble)"
                return s
            case .associatedString(let theString) :
                let s = "(Associated String) \(theString)"
                return s
            }
        }
    }
    
}



/*
 
 This structure is mainly used to "gather" multiple value types inside a single BANNER
 
 Example with color
 
 Color can be
 - hex
 - rgb
 - ...
 
 
    print(MyColors.rgb(125,100,88).toHEX) // > "#7D6458"
 
 */

enum MyColors {
    
    case hex(String)
    case rgb(Int,Int,Int)
    
    
    var toHEX : String {
        get {
            switch self {
            case .hex(let h) :
                return h
            case .rgb(let r, let g, let b) :
                let hexValue = String(format:"#") + String(format:"%02X", Int(r)) + String(format:"%02X", Int(g)) + String(format:"%02X", Int(b))
                return hexValue
            }
        }
    }
    
    // var toRGB : (Int, Int, Int) {
    //      ...
    // }
}



/*
                                                ERROR
 
 Gathering multiple value is really usefull when dealing with different result types
 
 Example with color
 
 Lets imagine we have a mathematical library, with many function that can throw a double OR an error.
 We can GATHER these two result inside a SINGLE ENUM
 
 Note : cf another example in Playground_Generics
 
 */


enum MyMathResult{
    
    case result(Double)
    case error(String)
    
    var desc : String {
        get {
            switch self {
            case .result(let d) :
                return "The result of the operation is \(d)"
            case .error(let s) :
                return "An error occured while computing operation : \(s)"
            }
        }
    }
    
}

class MyMathLib {
    
   class func squareRoot(_ d : Double) -> MyMathResult{
        if  d < 0 {
            return .error("Cannot calculate the squareRoot of a non-positive double")
        } else {
            return .result(sqrt(d))
        }
    }
}

/*
 
 print(MyMathLib.squareRoot(4).desc) // "The result of the operation is 2.0"
 print(MyMathLib.squareRoot(-1).desc) // "An error occured while computing operation : Cannot calculate the squareRoot of a non-positive double"
 
 > https://www.raywenderlich.com/130197/magical-error-handling-swift
 
 ... Actually we do not use this to handle errors, we use 'try catch' blocks, bnut it's still a thing to know
 To know how we do this please refet to Playground_Error_Handling...
 
 */



/*
 
                                             TYPENAMES
 
To go further, the 'Optional' type is a Generic Enum that will wrap any value, that can be defined or 'nil'

 
 print(MyOptional.some(Double(6)).desc) // MyOptional is not nil, it is 6.0
 print(MyOptional<Double>.none.desc)    // MyOptional is nil
 
 NOTE : !!! cannot write 'MyOptional.none.desc' -> we have to set the Generic Type  !!!
 ERROR : Generic parameter 'Wrapped' could not be inferred ( ~cannot guess generic type)
 
 */

enum MyOptional<Wrapped> {
    case some(Wrapped)
    case none
    
    var desc : String {
        get {
            switch self {
            case .none:
                return "MyOptional is nil"
            case .some(let w):
                return "MyOptional is not nil, it is \(w)"
            }
        }
    }
}

/*
 
ex:
     var myOptionalString : String? = "myString"
     <=>
     var myOptionalString : Optional<String> = "Princess Moana"
     <=>
     var myOptionalString = Optional<String>.some("Princess Moana")
 
 
 
     [...]
         The types of `shortForm` and `longForm` in the following code sample are
         the same:
 
         let shortForm: Int? = Int("42")
         let longForm: Optional<Int> = Int("42")
 
         The `Optional` type is an enumeration with two cases. `Optional.none` is
         equivalent to the `nil` literal. `Optional.some(Wrapped)` stores a wrapped
         value. For example:
 
         let number: Int? = Optional.some(42)
         let noNumber: Int? = Optional.none
         print(noNumber == nil)
         // Prints "true"
     [...]
 
 */






