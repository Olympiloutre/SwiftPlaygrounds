//
//  ViewController.swift
//  Playground_Embedded_Segue
//
//  Created by Romuald BROCHART on 13/06/2018.
//  Copyright © 2018 myself. All rights reserved.
//
/*
                                        EMBEDDED SEGUES
 
 Source : https://spin.atomicobject.com/2015/07/21/ios-container-views/
 
 Allow us to perform segues between 'portions' of view controller, included inside a Container View
 
 1. Drag a 'Container View' inside de ViewController
    > This Will automatically create another Viewcontroller in xib the same size of the container's frame
    > "After dragging the container view, constrain it to have the size and position you want in your view controller."
 
 
 2. Add a 'ViewController object' in the xib : this viewcontroller will be the second view controller inside the Container View
 
 3. Add a button in "First Container Viex Controller" that segues to "the Second Container View Controller".
    > Even if at first the second Viewcontroller was sized for full screen, linking it to a segue will automatically set it's size to fit !

 4. WARNING : Actually this won't work as simply : the second View Controller will just pop over the full screen
    Solution found on : https://stackoverflow.com/questions/37105809/container-view-segue-to-same-size-view-controller 
 
 5. You have, in the FIRST containe View Controller, enable the 'Define Context' option in the Attiribute Inspector from the storyboard
 
 6. Then, in the Segue from first to second view controller, you have to set a 'present modally' segue with 'presentation : Over Current Context' !!!
 
 
 At this point everythings works just fine
 
 
 
 
 
 
 */



import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad BaseViewController")
    }

}

