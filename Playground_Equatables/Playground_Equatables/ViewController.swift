//
//  ViewController.swift
//  Playground_Equatables
//
//  Created by Romuald BROCHART on 08/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Equatable
        let complex1 = Complex(real: 1, imaginary: 1)
        let complex2 = Complex(real: 1, imaginary: 1)
        
        // 1
        if( complex1 == complex2 ){
            print("complex1 et complex2 sont égaux")
        } else {
            print("complex1 et complex2 ne sont pas égaux")
        }
        
        // 2
        if( complex1 != complex2 ){
            print("complex1 et complex2 ne sont pas  égaux")
        } else {
            print("complex1 et complex2 sont égaux")
        }
        
        
        
        // Comparable
        let complex3 = Complex(real: 4, imaginary: 1)
        let complex4 = Complex(real: 2, imaginary: 2)
        
        // 3
        if( complex3 < complex4 ){
            print("complex3 est inférieur a complex4")
        } else {
            print("complex3 est supérieur a complex4")
        }
        
        // 4
        if( complex4 < complex3 ){
            print("complex4 est inférieur a complex3")
        } else {
            print("complex4 est supérieur a complex3")
        }
        
        
        
    }

}

