//
//  GeoNamesAPIClient.swift
//  MVVM_RxSwift
//
//  Created by Romuald Brochard on 2/5/19.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//
// From : https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb


import Foundation


/// Implementation of a generic-based GeoNames API Client
public class GeoNamesAPIClient: ApiClient {
    let baseEndpointUrl = URL(string: "http://api.geonames.org/")!
    let session = URLSession(configuration: .default)
    lazy var commonQueryItems = [
        URLQueryItem(name: "username", value: usernameKey)
    ]
    
    let usernameKey: String
    
    public init(username usernameKey: String) {
        self.usernameKey = usernameKey
    }
}
