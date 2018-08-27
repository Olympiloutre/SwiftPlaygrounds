//
//  ExampleConvenienceInit.swift
//  Playground_Enum_Class_Struct
//
//  Created by Romuald BROCHART on 27/08/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import Foundation
import UIKit

/*
 
    This is a direct Extension to ExampleClass about init and convenience init.
    This can be applied to Enum & Struct as Well
 
        
                                IV. CONVENIENCE INIT

    ( https://useyourloaf.com/blog/adding-swift-convenience-initializers/ )
 
 
    "A designated initializer is the primary initializer for a class. It must fully initialize all properties introduced by its class before calling a superclass initializer. A class can have more than one designated initializer.
 
    "A convenience initializer is a secondary initializer that must call a designated initializer of the same class. It is useful when you want to provide default values or other custom setup. A class does not require convenience initializers."
 
 */


extension UIImageView {
    
    // We extend UIImageView and add it a new initializer
    convenience init?(named name: String, contentMode: UIViewContentMode = .scaleToFill) {
        
        guard let image = UIImage(named: name) else {
            return nil // *
        }
        
        self.init(image: image)
        self.contentMode = contentMode
        translatesAutoresizingMaskIntoConstraints = false
    }
}


/*
 
 Usage :
    // Default contentMode
    let heart = UIImageView(named: "Heart")
 
    // Specifying a contentMode
    let star = UIImageView(named: "Star", contentMode: .scaleAspectFit)
 
 
 
 Note * :
    This initializer can return 'nil'. In fact if the image name parameter does not correspond to any image, the initializer will fail and therefore return 'nil'.
    To declare a nilable / failable initializer, just use 'init?' instead of 'init'
 
 */

