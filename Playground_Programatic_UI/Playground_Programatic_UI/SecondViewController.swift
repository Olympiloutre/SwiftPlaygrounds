//
//  SecondViewController.swift
//  Playground_Programatic_UI
//
//  Created by Romuald Brochard on 21/10/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//
/*
            Animation with Constraints
 
 This part is not specific to Programmatic UI. However, it's easier to understand it with constraints set programmatically
 
 sources :
 - https://www.youtube.com/watch?v=d1e9bKtOEH8&t=545s
 
 
 We use only constrains, we never get to use .frame
 
        // WRONG WAY ! - Use constraints
        self.blockView.frame = CGRect(x: 200, y: 0, width: 200, height: 50)

 
 1. Create Outlets ( programmatically or via storyboard )
 
 2. use variables to store NSLayoutConstraint that will be applied to the View
 
 3. disable/enable these NSLayoutConstraint vars in setup() to first place the View
 
 4. use UIView.animate() for animation
    a. before UIView.animate(), disable/enable NSLayoutConstraint's vars to match destination
    b. parametrize UIView.animate() ( duration, delay, options... )
    c. in UIView.animate() animation's block, recompute layout via `self.view.layoutIfNeeded()`
    d. (optional) do something on completion's block
 
 */
import UIKit

class SecondViewController: UIViewController {

    let blockView = UIView()
    let nextButton = UIButton()
    
    var leftConstraint : NSLayoutConstraint?
    var rightConstraint : NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupBlockView()
        setupNextButton()
    }
    
    func setupBlockView() {
        blockView.backgroundColor = .lightGray
        blockView.isUserInteractionEnabled = true
        blockView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didClickBlockView)))
        view.addSubview(blockView)
        setBlockViewConstraints()
    }
    
    func setBlockViewConstraints() {
        blockView.translatesAutoresizingMaskIntoConstraints = false // still important
        blockView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true   // in safeArea
        
        // Normal - fixed
        // blockView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true // in safeArea
        
        // Registered in variables - to be modified in animations
        leftConstraint = blockView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        leftConstraint?.isActive = true
        rightConstraint = blockView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        rightConstraint?.isActive = false
        
        
        blockView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        blockView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func didClickBlockView() {
        
        // Animation Handling
        
        // 4.a. Match destination anchors
        leftConstraint?.isActive = false
        rightConstraint?.isActive = true
        
        /// 4.b. alt + click for more infos on params
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
                        
                        // 4.c. recompute
                        self.view.layoutIfNeeded()
                        
                       },
                       completion: nil) // 4.d. Nothing in completion here
        
    }
    
    // MARK:- Next button
    func setupNextButton() {
        nextButton.backgroundColor = .white
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.setTitleColor(.red, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.addSubview(nextButton)
        setNextButtonConstraints()
    }
    
    
    func setNextButtonConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    
    @objc func nextButtonTapped() {
        
        let thirdViewController = ThirdViewController()
        thirdViewController.title = "TableView"
        navigationController?.pushViewController(thirdViewController, animated: true)
 
    }
    
    
}


/*
 
            --- Note on programmatic UI ---
 
 In this second source, from 'Let's build that app', there is another way to compute View's programmatically using a closure :
 
     var blockView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .lightGray
        return myView
     }
 
 then in viewDidLoad:
 
     override func viewDidLoad() {
         super.viewDidLoad()
         view.addSubview(blockView)
         setBlockViewConstraints()
     }
 
 The PROBLEM here is when adding 'UITapGestureRecognizer' inside blockView's closure, the 'self' reference is NOT known. Which mean we have to set a 'lazy' keyword, to tell compiler to only compute blockView when asked the first time
 
 
     lazy var blockView: UIView = {
         let myView = UIView()
         myView.backgroundColor = .lightGray
         myView.isUserInteractionEnabled = true
         myView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didClickBlockView)))
         return myView
     }
 
 
 This is another way to deal with programmatic UI. For now I used the previous method shown inside FirstViewController
 
 */
