//
//  ThirdViewController.swift
//  Playground_Programatic_UI
//
//  Created by Romuald Brochard on 29/11/2018.
//  Copyright © 2018 Romuald Brochard. All rights reserved.
//

/*
 
 .                  Programmatic UITableView
 
    A bit tricky
 
 To put it in a nutshel we have to recreate the binding mechanic we have in storyboard
 
 1. Define a unique cell ID ( which will be use as a reuse identifier )
 
 2. Tells the tableview to register our CustomCell class for this identifier
 
From there it looks much alike storyboard when coming to the Delegate and Datasource implementation 
 
 */

import UIKit

class ThirdViewController: UIViewController {

    let tableView = UITableView()
    
    let mock: [(String, UIColor)] = [("First",  .blue),
                                     ("Second", .green),
                                     ("Third",  .yellow)]
    
    
    // 1. Define a ReuseIdentifier For the cell
    let cellReuseIdentifier = "myCellReuseId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        // 2. add delegate like when using Storyboard
        tableView.delegate = self
        tableView.dataSource = self
        
        // 3. Register the cell we will be using
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // Very Important ! ~> https://stackoverflow.com/a/45768693/5464805
        /// Without it error :
        /// 1 - if nnothing registered :
        ///  'unable to dequeue a cell with identifier allCocktailCellId - must register a nib or a class for the identifier or connect a prototype cell in a storyboard'
        /// 2 - if wrong cell tyoe registered
        ///  'Could not cast value of type 'BartenderIOSApp.BTCocktailCell' (0x10b055da0) to 'BartenderIOSApp.BTCocktailAddCell' (0x10b0569e8).'
        
        view.addSubview(tableView)

        
        setupTableViewConstraints()
    }
    
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
}

// 4. Implement Delegate and Datasource
extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 5. like when using storyboard you cast the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CustomTableViewCell
        cell.title      = mock[indexPath.row].0
        cell.titleColor = mock[indexPath.row].1
        return cell
        
    }
    
    // 6. add action when cell clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
            print("\(cell.title) selected")
        }
    }
}
