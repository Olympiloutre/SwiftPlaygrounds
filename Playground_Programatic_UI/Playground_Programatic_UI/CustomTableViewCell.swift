//
//  TableViewCell.swift
//  Playground_Programatic_UI
//
//  Created by Romuald Brochard on 29/11/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//
/*
 .                  Programmatic UITableView

 Does NOT work like a standart UIVIew programmatic subclass concerning contraints!
 
"updateConstraints not called directly for UITableViewCell subclasses"
https://stackoverflow.com/questions/42158509/uitableviewcell-constraints-only-updated-after-reload
            ~> https://stackoverflow.com/a/45142666/5464805
 
 
Conclusion : should set constraints like normal Outlet, not as custom UIview ( not use updateConstraints )
 
 */

import UIKit

class CustomTableViewCell: UITableViewCell {

    let label = UILabel()
    
    var title : String? {
        didSet {
            label.text = title
        }
    }
    
    var titleColor : UIColor? {
        didSet {
            label.textColor = titleColor
        }
    }
    
    // 1. Init like a Custom UIView
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Note A: You can define more sophisticated initializers, or instance to set the optionals values
    /// e.g. init(title: String, titleColor: UIColor )
    
    // 2. Setups
    func setupLabel() {
        
        label.textAlignment = .center
        
        // 3 use `contentView`
        contentView.addSubview(label)
        
        /// Related to "Note A" - useless to set `title` and `titleColor` here considering they will be nil without a dedicated initializer that would set them before reaching this point
        /// In this case the view components are refreshed by `didSet` method
        /// label.text = title
        /// label.textColor = titleColor
        
        
        // 4. Call constraints like normal outlet
        setupLabelConstraints()
    }
    
    
    /// NOTE : does not work like custom UIViews... Do NOT place constraints like so
    /*
    var shouldSetupConstraints = true
 
    override func updateConstraints() {
        /// not called directly for UITableViewCell subclasses  - https://stackoverflow.com/a/45142666/5464805
        if(shouldSetupConstraints) {
            setViewsConstraints()
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    */
    
    // 5. Constraints
    func setupLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
