//
//  VendingMachine.swift
//  Playground_Error_Handling
//
//  Created by Romuald BROCHART on 11/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation


enum VendingMachineError : Error {
    
    case outOfStock
    case invalidSelection
    case insuficientCoin( coinNeeded : Int)
    
}

class VendingMachine {
    
   class func selection( selection : Int, insertedCoins : Int ) throws {
        
        // selections from 1 to 4
        if selection < 0 || selection > 5 {
            throw VendingMachineError.invalidSelection
            // return - Useless : "Code after 'throw' will never be executed"
        }
        
        
        // out of stock for #1
        if selection == 1 {
            throw VendingMachineError.outOfStock
            // return
        }
        
        
        // everything costs 5 coins
        if insertedCoins < 5 {
            let coinNeeded = abs(insertedCoins - 5)
            throw VendingMachineError.insuficientCoin( coinNeeded : coinNeeded )
            // return
        }
        
    }
    
}
