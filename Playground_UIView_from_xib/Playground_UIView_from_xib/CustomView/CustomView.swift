//
// CustomView.swift 
//
// Created by Qantas Dev on 5/9/19
// Copyright © 2019 Romuald Brochard. All rights reserved.
// 
//
///  XIB Notes:
///
/// - new file > View
///
/// - If you want to change the shape of your XIB, click on the attributes inspector in the upper right hand corner, and change size to freeform.
///
/// - Name of class and xib must match ( for comprehension and some shortcuts later on )
///
/// - Add `CustomView` As XIB File’s Owner
///
/// - Add Entire View as an IB Outlet in UIView File, under `contentView`
///


import Foundation
import UIKit

/// subclass of UIView (obvsly)
class CustomView: UIView {
    
    /// Add Entire View as an IB Outlet in UIView File
    @IBOutlet var contentView: UIView!
    
    /// Add other inner outlets as usual
    @IBOutlet var titleLabel: UILabel!

    
    /// Override inits and set custom init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Load XIB in Common Initializer
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

/// View is now ready to be used
