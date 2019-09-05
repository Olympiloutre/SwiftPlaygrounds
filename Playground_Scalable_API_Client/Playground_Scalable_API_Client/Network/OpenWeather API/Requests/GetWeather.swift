//
//  GetLocation.swift
//  MVVM_RxSwift
//
//  Created by Romuald Brochard on 2/5/19.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//

import Foundation

public struct GetWeather: APIRequest {
    public typealias Response = Location
    
    public var resourceName: String {
        return "weather"
    }
    
    private let querry: String?
    private let lat: String?
    private let lon: String?
    
    private enum CodingKeys: String, CodingKey {
        case querry = "q"
        case lat
        case lon
    }

    
    public init(querry: String? = nil,
                lat: String? = nil,
                lng: String? = nil) {
        
        self.querry = querry
        self.lat = lat
        self.lon = lng
        
    }
}


