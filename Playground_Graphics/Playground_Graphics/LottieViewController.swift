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
//
/// Note : If you have that kind of error : "Warning: fill effect not supported: XXX / XXX"
/// This means there are several effects that won't be displayed. Maybe the whole file
/// for instance the "bomb.json" file originally has a skull on it. It is not displayed
/// This is due to the editor used to create lottie animations. "Lottie relies on Adobe After Effects (AE)"
/// some effects are not handled by lottie.

import UIKit
import Lottie

class LottieViewController: UIViewController {
    
    // Lottie Outlets
    @IBOutlet weak var lottieAnimationView: LOTAnimationView!
    @IBOutlet weak var lottieCompletionView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loopAnimation()
        completionAnimation()
    }
    
    // MARK:- Simple loop animation
    /// settings are numerous, such as 'contentMode' which works like an UIImageView
    func loopAnimation() {
        lottieAnimationView.setAnimation(named: "bomb")
        lottieAnimationView.loopAnimation = true
        lottieAnimationView.autoReverseAnimation = true
        lottieAnimationView.play()
    }
    
    // MARK:- Animation with completion
    /// set loop animation from 0 to 0.7 of the lottie file (~correspond to the 'loading' part)
    /// simulate an async call with completion
    func completionAnimation() {
        lottieCompletionView.setAnimation(named: "cloud")
        lottieCompletionView.contentMode = .scaleAspectFill
        lottieCompletionView.loopAnimation = true
        lottieCompletionView.autoReverseAnimation = true
        lottieCompletionView.play(fromProgress: 0, toProgress: 0.7, withCompletion: nil)
        
        let dispatchTime = DispatchTime.now() + 4.0
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.simulateDownloadComplete()
        }
    }
    
    // Asyn completion
    /// disable infinite loop
    /// set completion for the current loop the animation is in ( will finish at progress 0.7 )
    /// in completion play animation once from 0.7 to 1 (~correspond to the 'finish' part)
    /// in this play completion write what will happen at the end
    fileprivate func simulateDownloadComplete(){
        lottieCompletionView.autoReverseAnimation = false
        lottieCompletionView.loopAnimation = false
        lottieCompletionView.completionBlock = { _ in ()
            self.lottieCompletionView.play(fromProgress: 0.7, toProgress: 1, withCompletion: { _ in
                print("Finish")
            })
        }
    }
}

