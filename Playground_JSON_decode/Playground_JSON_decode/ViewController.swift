//
//  ViewController.swift
//  Playground_JSON_decode
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//
// From :
// - https://medium.com/xcblog/painless-json-parsing-with-swift-codable-2c0beaeb21c1
// - https://benscheirman.com/2017/06/swift-json/ // more complex ! Ultimate guide

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        callAndDecode()
        createAndEncode()
    }
    
    fileprivate func callAndDecode() {
        guard let gitUrl = URL(string: "https://api.github.com/users/shashikant86") else { return }
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // tells date format (https://benscheirman.com/2017/06/swift-json/)
                
                let gitData = try decoder.decode(MyGitHub.self, from: data)
                
                print(gitData.name)
                print(gitData.avatarUrl)
                print(gitData.location)
                print(gitData.followers)
                print(gitData.repos)
                print(gitData.creation)

            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
    
    
    fileprivate func createAndEncode() {
        
        let myGit = MyGitHub.init(name: "romuald", location: "Sydney", followers: 140, avatarUrl: URL(string: "https://avatars0.githubusercontent.com/u/683799?v=4"), repos: 3, creation: Date())
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // tells date format 
        
        let data = try! encoder.encode(myGit)
        print(String(data: data, encoding: .utf8)!)
        
    }

}

