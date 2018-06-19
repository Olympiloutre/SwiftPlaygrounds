//
//  ViewController.swift
//  Playground_Generics
//
//  Created by Romuald BROCHART on 08/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//
// --------------- GENERICS --------------------
// https://www.raywenderlich.com/154371/swift-generics-tutorial-getting-started

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Intro
        
         Many Objects already uses Typenames - Generic types :
         - Arrays
         - Dictionnarys
         - Optionals ( yes )
         
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
        
        
        
        // 1. ----- Generic Functions -----
        
        let myArrayOfInts = self.toList(1,2,3,4,6,5,8,9,1)
        print("myArrayOfInts \(myArrayOfInts)")
        
        let myArrayOfStrings = self.toList("a", "b", "c", "d", "e", "f") // note : .toList('a', 1, 2.0) will throw an error
        print("myArrayOfStrings \(myArrayOfStrings)")
        
        
        
        let myDictionnary : [Int: String] = [1:"a", 2:"b", 3:"c"]
        let myTyplesFromDic = self.pairs(dic: myDictionnary)
        print("\( myDictionnary )")
        print("   becomes ->")
        print("\( myTyplesFromDic )")
        
        
        
        let myArrayWithoutDoublon : [String] = ["a", "b", "c", "d"]
        print("myArrayWithoutDoublon has doublon ? \(self.doublons(in: myArrayWithoutDoublon))")

        let myArrayWithDoublon : [Int] = [1,2,4,3,2]
        print("myArrayWithDoublon has doublon ? \(self.doublons(in: myArrayWithDoublon))")

        
        
        // 2. ----- Generic Class  -----
        
        // Note : if you don't specify the <> generic type : "Generic parameter 'GenericType' could not be inferred"
        let obj = ClassWithGenerics<String>()
        
        obj.add("A")
        obj.add("B")
        obj.add("C")
        
        print(obj.dequeu() ?? "no item")
        print(obj.dequeu() ?? "no item")
        print(obj.dequeu() ?? "no item")
        print(obj.dequeu() ?? "no item")

        
        
        // 3. ----- Enum With associated values -----
        /*
         This is the basis of any "functional” error-handling idiom
         
         This will allow you to write elegant error handling for a division method requested by the Queen – her final ask of you.
         */
        
        let result1 = divide(42, by: 2) // .success(21)
        let result2 = divide(42, by: 0) // .failure(MathError.divisionByZero)
        
        // print("result1 : \(result1)")
        // print("result2 : \(result2)")
        
        self.translatedResult(result1)
        self.translatedResult(result2)

        
        
        // Note: stop here -> The next part of this playground will be on Error Handling
        
        
        
    }

    
    
    
    
    // MARK:- 1*. Generic functions
    /*
     Simple one
     
     Note : Remainder, this signature means "as many Item you want to put in call"
     
     Transform a list of item passed in parameters into an Array of these items
    */
    func toList<Item> ( _ items : Item ... ) -> [Item]{
        
        var ret : [Item] = []
        
        for item in items {
            ret.append(item)
        }
        
        return ret
    }
    
    
    /*
     More sophicticated one
     
     Transformes a Dictionnary ( which is already a generic func ndlr) into a list of tuples
     */
    func pairs<Key, Value>( dic : [Key:Value] ) -> [(Key,Value)]{
        
        var ret: [(Key,Value)] = []
        
        for d in dic {
            ret.append((d.key, d.value))
        }
        
        return ret
    }
    
    
    /*
     Adding a constraint
     In some case you'll need to set a constraint on the Generic type to be used inside this function
     
     For instance Comparable and Equatable for functions that uses '==' or '<' between generic types
     
     return true if two elements of a list are equals
     
     Without this constraint an error occurs
                      ↡
     */
    func doublons<Item : Equatable>( in array : [Item] ) -> Bool{
        
        for item1 in array {
            
            var count = 0
            for item2 in array {
                
                if item1 == item2 { count += 1 }
                if count > 1 { return true }
            }
        }
        
        return false
    }
    
    
    
    
    
    
    // MARK:- 3*. Enum With associated values - based on the other class
    /*
     
     */
    func divide(_ x: Int, by y: Int) -> Result<Int> {
        guard y != 0 else {
            return .failure(MathError.divisionByZero)
        }
        return .success(x / y)
    }
    
    /*
     output
     
     > let result1 = divide(42, by: 2) // .success(21)
     > let result2 = divide(42, by: 0) // .failure(MathError.divisionByZero)
     
     */

    
    func translatedResult<Value>(_ result : Result<Value>) {
        
        // Note : cf error handling for that syntax ( 'case .failure( let e ) : ...' )
        switch result {
            case .failure( let e ) : print("An error occured : \(e)")
            case .success( let v ) : print("The result is \(v)")
        }
        
    }

}


// MARK:- Enums for "Enum With associated values" Part
/*
 The main use case for such an enum is as a return value for a function with specific error information using the standard library Error type, kind of like a more general optional.
 */
enum Result<Value> {
    case success(Value)
    case failure(Error)
}

/*
 Error Enum for mathematical errors ( cf func in ViewController )
 */
enum MathError: Error {
    case divisionByZero
}








