//
//  OpenWeatherAPIClient.swift
//  MVVM_RxSwift
//
//  Created by Romuald Brochard on 2/5/19.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//
// From : https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb


import Foundation


/// Implementation of a generic-based OpenWeather API client
public class OpenWeatherAPIClient: ApiClient {
    let baseEndpointUrl = URL(string: "http://api.openweathermap.org/data/2.5/")!
    let session = URLSession(configuration: .default)
    lazy var commonQueryItems = [
        URLQueryItem(name: "appId", value: appId)
    ]
    
    let appId: String
    
    public init(appId: String) {
        self.appId = appId
    }
    
}
