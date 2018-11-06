//
//  ViewController.swift
//  Playground_Graphics
//
//  Created by Romuald BROCHART on 06/11/2018.
//  Copyright © 2018 myself. All rights reserved.
//
// Lottie Playground
// sources :
// - https://www.youtube.com/watch?v=dM6u5FlZB70&list=LLN7qZovD8wBTBq8-M0Lj2Og&t=161s&index=4
// - https://github.com/airbnb/lottie-ios
//  Download animations in json format at https://www.lottiefiles.com/ & place it in resources

// Note : If you have that kind of error : "Warning: fill effect not supported: XXX / XXX"
// This means there are several effects that won't be displayed. Maybe the whole file
// for instance the "bomb.json" file originally has a skull on it. It is not displayed
// This is due to the editor used to create lottie animations. "Lottie relies on Adobe After Effects (AE)"
// some effects are not handled by lottie.

import UIKit
import Lottie

class LottieViewController: UIViewController {
    
    // Lottie Outlets
    @IBOutlet weak var lottieAnimationView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loopAnimation()
    }
    
    func loopAnimation() {
        
        lottieAnimationView.setAnimation(named: "bomb")
        lottieAnimationView.loopAnimation = true // tell infinite loop
        lottieAnimationView.autoReverseAnimation = true
        lottieAnimationView.play()
    }
    
    
}

