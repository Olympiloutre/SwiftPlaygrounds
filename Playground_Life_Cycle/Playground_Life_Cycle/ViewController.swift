//
//  ViewController.swift
//  Playground_Life_Cycle
//
//  Created by Romuald Brochard on 01/12/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//

import UIKit


//MARK:-                            UIViewController LifeCycle Part
/// From https://stackoverflow.com/a/32688124/5464805


class ViewController: UIViewController {
    
    
    
    /*
     These methods are in correct order.
     */
    
    
    /*
     "This event creates the view that the controller manages. It is only called when the view controller is created programmatically. This makes it a good place to create your views in code."
     
     `This is where subclasses should create their custom view hierarchy if they aren't using a nib.
     Should never be called directly. `
     
     "loadView() is always called, it just shouldn't be overridden when view for controller created in IB"
     
     */
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    
    /*
     "If incase the view of current viewController has not been set yet then this method will load the view but remember, this is only available in iOS >=9.0. So if you are supporting iOS <9.0 then don't expect it to come into the picture."
     
     `Loads the view controller's view if it has not already been set.`
     */
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        print("loadViewIfNeeded")
    }
    
    
    /*
     "The viewDidLoad event is only called when the view is created and loaded into memory but the bounds for the view are not defined yet. This is a good place to initialise the objects that the view controller is going to use."
     
     `Called after the view has been loaded. For view controllers created in code, this is after -loadView.
     For view controllers unarchived from a nib, this is after the view is set.`
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    
    /*
     "This event notifies the viewController whenever the view appears on the screen. In this step the view has bounds that are defined but the orientation is not set."
     
     `Called when the view is about to made visible. Default does nothing.`
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    
    /*
     "This is the first step in the lifecycle where the bounds are finalised. If you are not using constraints or Auto Layout you probably want to update the subviews here. This is only available in iOS >=5.0. So if you are supporting iOS <5.0 then don't expect it to come into the picture."
     
     `Called just before the view controller's view's layoutSubviews method is invoked.
     Subclasses can implement as necessary. The default is a nop.`
     */
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }
    
    
    /*
     "This event notifies the view controller that the subviews have been setup. It is a good place to make any changes to the subviews after they have been set. This is only available in iOS >=5.0. So if you are supporting iOS <5.0 then don't expect it to come into the picture."
     
     `Called just after the view controller's view's layoutSubviews method is invoked.
     Subclasses can implement as necessary. The default is a nop.`
     */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
    }
    
    /*
     Note : "viewWillLayoutSubviews and viewDidLayoutSubviews will also be called at other times when subviews of the main view are loaded, for example when cells of a table view or collection view are loaded."
     */
    
    
    
    
    /*
     "The viewDidAppear event fires after the view is presented on the screen. Which makes it a good place to get data from a backend service or database."
     
     `Called when the view has been fully transitioned onto the screen. Default does nothing`
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    
    /*
     "The viewWillDisappear event fires when the view of presented viewController is about to disappear, dismiss, cover or hide behind other viewController. This is a good place where you can restrict your network calls, invalidate timer or release objects which is bound to that viewController."
     
     `Called when the view is dismissed, covered or otherwise hidden.`
     */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    
    /*
     "This is the last step of the lifecycle that anyone can address as this event fires just after the view of presented viewController has been disappeared, dismissed, covered or hidden."
     
     `Called after the view was dismissed, covered or otherwise hidden.
     Default does nothing`
     */
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
}



//MARK:-                               setNeedsLayout vs layoutIfNeeded vs layoutSubviews - update cycle
/// From : https://medium.com/@abhimuralidharan/ios-swift-setneedslayout-vs-layoutifneeded-vs-layoutsubviews-5a2b486da31c

extension ViewController {
    
    /*
     
     When an iOS app launches, UIApplication in iOS starts the main run loop for an app, which runs on the main thread.
     The main run loop processes events (such as user touches) and handles updates to view-based interfaces.
     As events occur, such as touch, location updates, motion, and multimedia control, the run loop finds the appropriate handler for the events, calling appropriate methods, which call other methods, and so on.
     At some moment in time, all events will have been handled and control will return to the run loop.
     Let’s label this point where control is returned to the run loop as the update cycle.
     
     
     While the events are being processed, and some changes are requested to the view, these changes are not updated immediately.
     Instead the system wait for the existing process to finish and when the next redraw cycle is going to happen.
     There is a periodic interval between the event processing and UI layout update handling.
     This is why we need to understand the above three methods properly.
     
     
     */
    
    
    
    
    /*
     The method setNeedsLayout for a UIView tells the system that you want it to layout and redraw that view and all of its subviews, when it is time for the update cycle.
     This is an ASYNCHRONOUS activity, because the method completes and returns immediately, but it isn’t until some later time that the layout and redraw actually happens, and you don’t know when that update cycle will be.
     
     view.setNeedsLayout()
     
     */
    
    
    /*
     In contrast, the method layoutIfNeeded is a SYNCHRONOUS call that tells the system you want a layout and redraw of a view and its subviews, and you want it done immediately without waiting for the update cycle.
     When the call to this method is complete, the layout has already been adjusted and drawn based on all changes that had been noted prior to the method call.
     
     view.layoutIfNeeded()
     
     */
    
    
    
    /*
     
     view.layoutSubviews()
     
     The default implementation uses any constraints you have set to determine the size and position of any subviews.
     Subclasses can override this method as needed to perform more precise layout of their subviews. You should override this method only if the autoresizing and constraint-based behaviors of the subviews do not offer the behavior you want
     
     You should NOT call this method directly:
     - If you want to force a layout update, call the `setNeedsLayout()`
     - If you want to update the layout of your views immediately, call the `layoutIfNeeded()`
     
     */
    
    
    
    
    
    
}


//MARK:-                               setNeedsDisplay
extension ViewController {
    
    /*
     
     view.setNeedsDisplay()
     
     You can use this method or the setNeedsDisplay(_:) to notify the system that your view’s contents need to be redrawn.
     ASYNCHRONOUS : The view is not actually redrawn until the next drawing cycle, at which point all invalidated views are updated.
     
     linked to the `func draw(_ rect: CGRect)` method
     
     You should use this method to request that a view be redrawn only when the content or appearance of the view change.
     If you simply change the geometry of the view, the view is typically not redrawn.
     
     Note: Redisplaying the existing content improves performance by avoiding the need to redraw content that has not changed.
     
     */
    
    
    
}
