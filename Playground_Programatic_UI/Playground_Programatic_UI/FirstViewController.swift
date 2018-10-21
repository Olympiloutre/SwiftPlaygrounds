//
//  ViewController.swift
//  Playground_Programatic_UI
//
//  Created by Romuald Brochard on 21/10/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//

/*
                    Programatic UI
 
 sources :
 - https://www.youtube.com/watch?v=1hCwOIgjLBA&t=4s&list=LLN7qZovD8wBTBq8-M0Lj2Og&index=6 ( base tuto )
 - https://www.youtube.com/watch?v=g6yz5oX5iWc ( why don't I use storyboard )
 
 This is the idea of not using the Storyboard in applications.
 This is really handy when it comes to work with ViewController that are using Generic types, or that are intended to be subclassed.
 
 
 1. Delete Main.storyboard > to Trash
    Note: if we run at this point, it will crash 'cannot find Main.sotryboard'
 
 2. in the info.plist > remove 'Main sotryboard file name base'
    Note: if run at this point, no crash but a black screen
 
 3. Appdelegate > didFinishLaunchingWithOptions() > Add 3 lines that instanciate a window and the first ViewController
 
            window = UIWindow(frame: UIScreen.main.bounds)      // create a window of the size of a screen
            window?.rootViewController = FirstViewController()  // instanciate a FirstViewController
            window?.makeKeyAndVisible()                         // show the window
 
 4. As I want the application to be nested into a NavigationController, I created my own subclass of navigationcontroller and set it as the default 'rootViewController'. didFinishLaunchingWithOptions becomes :
 
            let firstViewController = FirstViewController()
            let navigationController = RootNavigationController(rootViewController: firstViewController)
 
            window = UIWindow(frame: UIScreen.main.bounds)      // create a window of the size of a screen
            window?.rootViewController = navigationController   // tell to start with 'navigationController'
            window?.makeKeyAndVisible()                         // show the window
 
 5. The app runs, a NavigationController hosts out firstViewController. Now just create buttons and view programmatically inside the code.
 
 */

import UIKit

class FirstViewController: UIViewController {

    var nextButton = UIButton()
    // var nexttButton: UIButton // possible but requires an 'init' override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupNextButton()
    }
    
    func setupNextButton() {
        // set buttons graphics
        nextButton.backgroundColor = .white
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.setTitleColor(.red, for: .normal)
        
        // set buttons action - works with selector
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        
        // add to the view
        view.addSubview(nextButton)
        // Note: at this point no constraint so the button doesn't appear, because the UI doesn't know how to put it
        
        // set button constraints
        setNextButtonConstraints()
    }
    
    func setNextButtonConstraints() {
        // set Autolayout to false.
        // 'Often times when you find something not working properly, you should set this property to false for one of your UI element'
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        // set anchors
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        /*
         This is the Apple Way to set Anchors.
         There are 3rd part libraries that can do this less verbosefull, such as snapkit or tinyConstraints
         
         Most of the time you just need 4 constraints for one component.
         
         On each constraint you have to set '.isActive = true' otherwise the constraint is not activated and not computed by the UI.
         It is possible to do an extension of that class that would not require to set 'isActive' to true each time but here is the default way to deal with constraints
         
         You have to set your constraints AFTER you added you subview to the view.
            1. view.addSubview(nextButton)
            2. setNextButtonConstraints()
         
         */
    }
    
    // @obj to work with #selector.
    // Error 'Argument of '#selector' refers to instance method 'nextButtonTapped()' that is not exposed to Objective-C'
    @objc func nextButtonTapped() {
        
        // Here a segue inside a NavigationController
        // Similar to AppDelegate, we have to create that screen
        let secondViewController = SecondViewController()
        
        // Now that we have our instance of 'SecondViewController' we can start altering it's datas ( background colors, inner variables etc... )
        // Here we set the 'title' var which is defaultly present in UIViewController, and will be displayed at top of UINavigationController if it exists as an ancestor
        secondViewController.title = "Aaaah Yeah"
        
        // 'navigationController' var get an ancestor of this view that is a navigationController. nil if does not exists
        // related to the rootNavigationController we set in appDelegate nesting te FirstViewController instance
        navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
}

