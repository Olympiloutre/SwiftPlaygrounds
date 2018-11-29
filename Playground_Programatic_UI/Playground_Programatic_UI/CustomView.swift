//
//  CustomView.swift
//  Playground_Programatic_UI
//
//  Created by Romuald BROCHART on 15/11/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
///
/// Default method to create custom UIViews
/// https://medium.com/written-code/creating-uiviews-programmatically-in-swift-55f5d14502ae
/// https://stackoverflow.com/a/34302770/5464805



import UIKit

class CustomView: UIView {

    var shouldSetupConstraints = true
    
    var innerLabel: UILabel!
    
    /*
     
     Setups and adding the subviews in `init`s methods
     Also we could have set `var innerLabel: UILabel! = UIlabel()`
     
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSelf()
        setupLabel()
    }
    
    fileprivate func setupSelf(){
        // setup the view itself
        self.translatesAutoresizingMaskIntoConstraints = false // (  !! important )
        backgroundColor = .black
    }
    
    fileprivate func setupLabel(){
        // setup Label
        innerLabel = UILabel() // could have been set directly in definition `var innerLabel: UILabel! = UIlabel()`
        innerLabel.text = "Custom Programatic View"
        innerLabel.textColor = .white
        
        // add to view
        self.addSubview(innerLabel)
    }
    
    /*
     
     "Since we are adding constraints in a UIView subclass, we should override the updateConstraints method."
     ~> Allows us to set constraints after the view were loaded by the UI
     
     */
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            // Setting Layout here
            setLabelConstraints()
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    fileprivate func setLabelConstraints(){
        innerLabel.translatesAutoresizingMaskIntoConstraints = false
        innerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        innerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
