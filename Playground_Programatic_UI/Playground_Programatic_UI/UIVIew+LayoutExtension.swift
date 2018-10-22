//
//  UIVIew+LayoutExtension.swift
//  Playground_Programatic_UI
//
//  Created by Romuald BROCHART on 22/10/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//

/*
 
            --- Helpfull extensions to manage AutoLayout simply ---
 
    As written in FirstViewController, there is some 3rd part libraries that help to handle constraints with less code.
 
    It can already be achieved writting simple extensions
 
    Source :
    - https://www.youtube.com/watch?v=iqpAP7s3b-8
 
 */

import Foundation
import UIKit

extension UIView {
    
    
    /*
     'FirstViewController' we can se that block of code :
     
         // set anchors
         nextButton.translatesAutoresizingMaskIntoConstraints = false
         nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
         nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
         nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
         nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
     
     This can be summed up this way via an extension:
     
     */

    
    func anchor(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor) {
        
        // As said in 'FirstViewController' this basically "sets autolayout". Without it weird bord effects can occure
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // sets 4 anchors
        topAnchor.constraint(equalTo: top).isActive = true
        leadingAnchor.constraint(equalTo: leading).isActive = true
        trailingAnchor.constraint(equalTo: trailing).isActive = true
        bottomAnchor.constraint(equalTo: bottom).isActive = true
        
    }
    
    /*
        You now just have to call 'nextButton.anchor(...)' instead of the 5 previous lines
     */
    
    
                // --- ENHANCEMENT #1 ---
    
    
    /*
        This is an enhanced version of the previous functions.
        This allows us to set a padding inside
     */
    func anchor(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, padding: UIEdgeInsets) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // don't forget the '-' for bottom and trailing
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        
    }
    /*
         Note: these two functions could have been factorized just by adding 'padding: UIEdgeInsets = .zero'
         This sets a default value of 0 to all 4 directions padding, allowing the user to not specify it in call.
         The first function would have been a particular case of the second one, with the exact same syntax
     
        myView.anchor( ... , padding: .init(top: 0, left: 16, bottom: 0, right: 16)) // for instance
     
     */

    // --- ENHANCEMENT #2 ---
    
    
    /*
        Same thing but with a size
        As it requires to have 4 constraints maximum to fix a view, we have to set this a little bit differently
     */
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets, size: CGSize) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    /*
        Same thing, we could have summed up all these function by using a default value for the 'size' parameters ( size: CGSize = .zero )
        myView.anchor( ... , size: .init(width: 100, height: 100)) // for instance
     */
    
}


