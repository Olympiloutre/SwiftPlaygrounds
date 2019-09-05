//
// ViewController.swift 
//
// Created by Qantas Dev on 5/9/19
// Copyright © 2019 Romuald Brochard. All rights reserved.
//
// Sources:
// - https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb

import UIKit

class ViewController: UIViewController {

    let geoNamesClient = GeoNamesAPIClient(username: "olympiloutre")
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Example
        geoNamesClient.send(GetGeoNames(querry: "Paris")) { [weak self] response in
            switch response {
            case .success(let geonames):
                guard let countryName = geonames.list.first?.countryName else { return }
                print("GeoNames API returns - \(countryName)")
                DispatchQueue.main.async {
                    self?.label.text = countryName
                }
            case .failure(let error):
                print("GeoNames API Error - \(error)")
            }
        }
    }
}

