//
//  SharedInstanceExample.swift
//  Playground_SharedInstance
//
//  Created by Romuald BROCHART on 25/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation


/*  ---- THE ONE AND ONLY WAY ---- */


class MySingleton {
    
    static let sharedInstance = MySingleton()
    
    var param : String = "default"
    
    //adding 'private' prevents others from using the default '()' initializer for this class.
    private init() {}
    
}

/*
 
 Usage :
 
 Accessing :
     print("my singleton param : \(mySingleton.sharedInstance.param)")
     mySingleton.sharedInstance.param = "modified"
     print("my singleton param : \(mySingleton.sharedInstance.param)")
 
 
 Note : Accessible wherever we are in the app
 
 */



