//
//  SecondViewController.swift
//  Playground_RxSwift_Basis
//
//  Created by Romuald Brochard on 29/4/19.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//
/*
 
                    RxSwift & RxCocoa example
 
 source :
 - https://medium.com/@arnavgupta180/learn-and-start-writing-rxswift-within-few-minutes-119f8f25af68
 
 */

import UIKit
import RxSwift
import RxCocoa

class SecondViewController: UIViewController {
    
    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var myButton: UIButton!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
        setupButton()
    }
    
    fileprivate func setupTextField() {
        
        // Bind Rx action to Textfield
        /// Will be called on each text change
        myTextField.rx.text.subscribe(onNext:{ text in
            print("text: \(text)")
        }).disposed(by: disposeBag)
        
        /// Will be called on begin & end editing
        myTextField.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .asObservable() // convert as observable
            .subscribe(onNext: {
                print("edit begin/end")
            }).disposed(by: disposeBag)
    }

    fileprivate func setupButton() {
        
        // Bind Rx action to Textfield
        /// Will be called on each text change
        myButton.rx.tap.subscribe(onNext:{ [weak self] in
            self?.myTextField.text = ""
            print("tap")
        }).disposed(by: disposeBag)
    }
    
    
}
