//
//  ViewController.swift
//  Playground_Dependency_Injection_Test
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//

/*
 
    DEPENDENCY INJECTION EXAMPLE

 
 Note: For UIViewController I used property injection because constructor injection won't work with storyboard segues :
https://stackoverflow.com/questions/35315404/custom-init-for-uiviewcontroller-in-swift-with-interface-setup-in-storyboard/39400793#39400793
 
 */

import UIKit

// 1 - Create a protocol that will defiene which method will fill the datas
protocol Service {
    func load() -> [String]
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: [String] {
        get {
            return service?.load() ?? []
        }
    }
    
    // 2 - property method injection
    var service: Service? = MainService()
    // Note: due to the fact that constructor injection won't work with storyboard segues, I used property injections
    // However, concerning this is the root view controller, I have to provide it a default Service.
    // Else, I could have set this property in prepareForSegue(..) method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

// UITableViewDelegate & UITableViewDataSource Stack
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = data[row]
        return cell
    }
    
}


// 3 - Default service
/// This is the service that is used inside the application when not in test mode
class MainService: Service {
    func load() -> [String] {
        
        // just imagine it is a server call
        return ["AAA","BBB","CCC","DDD"]
    }
}
