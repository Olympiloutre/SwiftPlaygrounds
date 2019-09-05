//
//  ViewController.swift
//  Playground_KeyChain
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//
// https://medium.com/ios-os-x-development/securing-user-data-with-keychain-for-ios-e720e0f9a8e2

import UIKit
import SwiftKeychainWrapper

class PWDViewController: UIViewController {

    @IBOutlet weak var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clickSavePwd(_ sender: Any) {
        
        if let pwd = pwdTextField.text {
            let saveSuccess = KeychainWrapper.standard.set(pwd, forKey: "secure_password")
            print("save success: \(saveSuccess)")
            self.view.endEditing(true)
        }
    }
    
    @IBAction func clickRetrievePwd(_ sender: Any) {
        
        guard let retrievedPassword = KeychainWrapper.standard.string(forKey: "secure_password") else { return }
        print("Retrieved passwork is: \(retrievedPassword)")
    }
}

