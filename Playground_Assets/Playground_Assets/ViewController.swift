//
//  ViewController.swift
//  Playground_Assets
//
//  Created by Romuald Brochard on 21/10/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//
/*
                Playground Assets Catalogue
 
    .xcassets files let's us to register some objetcs that can be used inside the app more lightly.
    For instance we can register Colors and Images, that will be easily pickable inside the app while coding
 
 Sources :
 - https://www.youtube.com/watch?v=AVY1PXGqBN0&t=236s
 - https://www.google.fr/search?q=colors+asset+swift&oq=colors+asset+swift&aqs=chrome..69i57.1781j0j4&sourceid=chrome&ie=UTF-8
 
    I. --- Images --- !! warning - buggy
 
 1. Drag images to Assets.xcassets
 
 2. type 'image' and autocomplete will propose 'image Literal', Enter
 
 3. Double click on the icon and select image
 
 
    II. --- Colors ---
 
 1. In Assets.xcassets > '+'
 
 2. Change name and configure
 
 3. Use in code by refering to it's name
 
 */

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 'imag..' > 'image Literal' > Double click
        imageView.image = #imageLiteral(resourceName: "photo_2")
        
        // no completion here
        view.backgroundColor = UIColor(named: "CustomGreen")
        
    }
}

