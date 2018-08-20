//
//  ViewController.swift
//  ClosurePlayground
//
//  Created by Romuald Brochard on 17/05/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//

/*
 
 This is a Closure Playground
 This will show example of many closure examples
 
 
 Definition & Aspects
 "Closures are self-contained blocks of functionality that can be passed around and used in your code."
 
 CONTEXT : They can capture & register vars inside their context
 
 3 types :
 - global & nested func (particular case)
 - closures
 
 
 */



import UIKit

class ViewController: UIViewController {
    
    
    var aClosure: () -> () = {}
    var aVar : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // --- 1. Syntax ---
        //   PARAMS -> RETURN  -> defines params and returns of the function
        // "( PARAMS DEF ) in" -> allows us to define params
        
        print(" --- 1. Syntax --- ")
        
        var syntaxClosure : ( String, String ) -> () = { (s1,s2) in
            print("first String : '\(s1)' & second String : '\(s2)'")
        }
        
        //   A syntax is called like an actual function
        syntaxClosure("ma", "closure")
        
        
        //   Also this is a variable, passed by reference, so you can redefine it
        //   Plus, considering params definition, we can skip it by using $0 $1 ... to refer to parameters
        syntaxClosure = {
            print("first String : '\($0)' & second String : '\($1)'")
        }
        
        syntaxClosure("no", "definition")
        
        
        
        
        // --- 1.5. single statement closures ---
        //   "In closure having a single statement, this statement constitute a return"
        
        print(" --- 1.5. single statement closures --- ")
        
        //   Single statement closure
        var singleStatClosure : (Int) -> (Int) = {
            $0 * $0 // implicit 'return'
        }
        print(singleStatClosure(2)) // = 4
        
        //   Also works with '(x) in'
        singleStatClosure = { (x) in
            x * x // implicit 'return'
        }
        print(singleStatClosure(3)) // = 6
        
        
        
        
        // --- 2. Context ---
        //   Closures have their OWN context
        //   They can capture value and retain their ref ! ( which is really helpfull )
        //   Note : when () -> () you can skip it ( 'let closure = {' )
        
        print(" --- 2. Context --- ")
        
        var num = 0
        let contextClosure : () -> () = {
            num += 1
        }
        
        print(num)          // = 0
        contextClosure()    // +1
        contextClosure()    // +1
        num+=1              // +1
        print(num)          // = 3
        contextClosure()    // +1
        print(num)          // = 4
        
        
        
        // You can also use a 'capture list' which will make the closure works differently
        // Instead of capture an object in its context via 'reference' it copies it via 'value'
        print(" --- 2.5 Capture list --- ")
        
        var num_copied = 0
        let captureListClosure : () -> () = { [num_copied] in // Syntax of capture list. 'num_copied' is copied!
            print(num_copied)
        }
        num_copied += 1
        
        print(num_copied)    // => 1
        captureListClosure() // => 0 because num_copied is in capture list, therefore a copy

        
        // --- 3. Reference ---
        //   Closure are passed by refs
        //   Therefore they can consitute a function return
        
        print(" --- 3. Reference --- ")
        
        //   a function that create an iterator, i.e. a closure that take no params and returns an integer
        func makeIterator( from start: Int, step : Int ) -> ( () -> (Int) ) {
            
            var i = start
            
            //   Note : cf 2. -> variable 'i' will be registered inside closure's context, so accessible inside it
            let iterator : () -> (Int) = {
                i += step
                return i
            }
            
            return iterator
        }
        
        //   make an iterator which starts from 0 and count 1 to 1
        var ite = makeIterator(from: 0, step: 1)
        print(ite()) // +step and print = 1
        print(ite()) // +step and print = 2
        print(ite()) // +step and print = 3
        
        //   make an iterator which starts from 5 and count 3 to 3
        ite = makeIterator(from: 5, step: 3)
        print(ite()) // +step and print = 8
        print(ite()) // +step and print = 11
        print(ite()) // +step and print = 14
        
        
        
        
        
        // --- 4. Trailing Syntax ---
        //   "If the last parameter of a function is a closure, you can write it after"
        //   e.g. number.sort{ $0 < $1 } -> expect a closure
        
        print(" --- 4. Trailing Syntax --- ")
        
        //   This function make a sum of function
        func sum( from: Int, to: Int, f: (Int) -> (Int)) -> Int {
            
            var res = 0
            for i in from...to {
                res += f(i)
            }
            return res
        }
        
        //   Sum from 1 to 10 of simple number
        //   Trailing syntax                ↓
        var result = sum( from: 1, to: 10 ) { (x) in
            return x
        }
        print(result) // => 55
        
        
        //  Sum from 10 to 15 of squarre ( also shortcuting with '$x' )
        //   Trailing syntax             ↓
        result = sum( from: 10, to: 15 ) {
            return $0 * $0
        }
        print(result) // => 955
        
        
        
        
        
        // --- 5. Higher Order Functions ---
        //   High order function is :
        //   - either an input func
        //   - or an output func
        //   (Sorted, Map, Filter, Reduce)
        
        print("--- 5. Higher Order Functions ---")
        
        //   e.g. Map : transform an array using a function
        
        let nums = [1,2,3]
        var strings : [String] = []
        
        //   the for...in way
        for num in nums {
            strings.append("\(num)")
        }
        print(strings) // ["1","2","3"]
        
        
        //   the Map way ♥
        //   the .map() function takes a closure, with 1 param of array type and returns <T>
        //   Note : implicit 'return', shortcut
        strings = nums.map{"\($0)"}
        print(strings) // ["1","2","3"]
        
        
        //   Filter : closure return a Bool
        //   Reduce : combines all array in one - closure takes two params and return one
        //       init val  ↓      ↓  partial value plus array element
        print( nums.reduce(0, {$0 + $1}) ) // -> (((0 + 1) + 2) + 3) = 6
        
        
        
        
        
        // --- 6.Escaping Closures ---
        // https://medium.com/@kumarpramod017/what-do-mean-escaping-and-nonescaping-closures-in-swift-d404d721f39d
        // it is a way to add closure in function right after it's call. It's merely only syntax smoothing
        print("--- 6.Escaping Closures ---")
        func escapingFunc(completion:  @escaping () -> ()) {
            print("escaped")
            completion()
        }
        
        escapingFunc() { // note the '()' is not mandatory is there is not parameters
            print("my closure action")
        }
        
        
        
        // --- 7.Weak / Unowned self ---
        // https://stackoverflow.com/a/24320474/5464805
        // as said earlier, closures can retain values in their context
        // if in a closure we call self. then it will be retained, therefore creating a strong ref cycle
        // See - Arc Memory Management Playground
        print("--- 7.[unowned self] [weak self] ---")
        
        // This will create a strong ref cycle, self retaining aClosure, and aClosure retaining self, considering it's calling it inside it's context...
        self.aClosure = {
            self.aVar += 1
        }
        self.aClosure()
        print("aVar = \(self.aVar)")
        
        
        // ... by adding [unowned self] or [weak self] at the beginning of the closure, we are telling swift not to retain self if it comes to be deallocated...
        self.aClosure = { [unowned self] in
            self.aVar += 1
        }
        self.aClosure()
        print("aVar = \(self.aVar)")
        
        //... "The difference between unowned and weak is that weak is declared as an Optional while unowned is not. By declaring it weak you get to handle the case that it might be nil inside the closure at some point. If you try to access an unowned variable that happens to be nil, it will crash the whole program. So only use unowned when you are positive that variable will always be around while the closure is around"...
        
        
        
    }
    
}

