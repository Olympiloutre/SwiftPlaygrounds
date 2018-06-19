//
//  ViewController.swift
//  Playground_Error_Handling
//
//  Created by Romuald BROCHART on 11/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//
// https://www.raywenderlich.com/130197/magical-error-handling-swift
//
// ----- ERROR HANDLING -----


import UIKit


enum MyError : Error {
    
    case simpleError
    case parametrizedError( log: String )
    // 'case parametrizedError(_ log : String )' doesn't work - use 'case parametrizedError( String )'

}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // 1. ----- Simple throw -----
        // the do - catch statement is mandatory for function that twors something
        do {
            
            try self.throwSimpleError()
        } catch MyError.simpleError {
            
            print("a simple error is thrown")
        } catch {
            // Catch any other errors
            // -> Otherwise lack of exhaustivity error occures in xcode
        }
        
        
        
        
        // 2.  ----- Parametrized Error -----
        // gathering the parameter from a paramaetrized error ( eg and error log )
        do {
            
            try self.throwParametrizedError()
        } catch MyError.parametrizedError( let log ) {
            
            print("a parametrized error is thrown - log : \(log)")
        } catch {
            // Catch any other errors
        }
        
        
        
        
        // 3.  ----- Full example -----
        //   invalidSelection
        do {
            try VendingMachine.selection(selection: 6, insertedCoins: 10)
        } catch VendingMachineError.invalidSelection {
            print("Selection is invalid")
        }catch VendingMachineError.outOfStock {
            print("Out of stock")
        }catch VendingMachineError.insuficientCoin(let coinNeeded) {
            print("Missing coin : \(coinNeeded)")
        } catch {
            
        }
        
        //   outOfStock
        do {
            try VendingMachine.selection(selection: 1, insertedCoins: 10)
        } catch VendingMachineError.invalidSelection {
            print("Selection is invalid")
        }catch VendingMachineError.outOfStock {
            print("Out of stock")
        }catch VendingMachineError.insuficientCoin(let coinNeeded) {
            print("Missing coin : \(coinNeeded)")
        } catch {
            
        }
        
        //   insuficientCoin
        do {
            try VendingMachine.selection(selection: 4, insertedCoins: 3)
        } catch VendingMachineError.invalidSelection {
            print("Selection is invalid")
        }catch VendingMachineError.outOfStock {
            print("Out of stock")
        }catch VendingMachineError.insuficientCoin(let coinNeeded) {
            print("Missing coin : \(coinNeeded)")
        } catch {
        }
        
        
        // 4.  ----- Furthermore -----
        //   try? - return optionnal
        let x1 = try? self.shouldThrowError(b: false) // x1 = 0
        let x2 = try? self.shouldThrowError(b: true) // x2 = nil
        
        //   try! - unwrap it ( and so may causes the app to crash )
        let x3 = try! self.shouldThrowError(b: false) // x3 = 0
        // let x4 = try! self.shouldThrowError(b: true) // nil and the app will crash

        print(" x1 : \(x1) | x2 : \(x2) | x3 : \(x3) | x4 would crash the app")
    }
    
    
    
    // 1*. Simple throw
    // A function tha tthrow a simple error type
    // 'func throwSimpleError() throws -> void' also works
    func throwSimpleError() throws  {
        
        throw MyError.simpleError
        
    }
    
     // 2*. Parametrized Error
    // A function that throws a parametrized error
    func throwParametrizedError() throws {
        
        throw MyError.parametrizedError(log :"error param")
        
    }
    
    
    // 4*. Another function 
    func shouldThrowError( b : Bool ) throws -> Int{
        
        if b {
            throw MyError.simpleError
        }
        
        return 0
    }
    
    
}

