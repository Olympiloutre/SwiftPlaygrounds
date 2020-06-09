//
//  GeoName.swift
//  MVVM_RxSwift
//
//  Created by Romuald Brochard on 30/4/19.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//

import Foundation

public struct GeoNames: Codable {
    public let list: [GeoName]
    
    private enum CodingKeys: String, CodingKey {
        case list = "geonames"
    }
}

public struct GeoName: Codable {
    public let name: String
    public let lat: String
    public let lng: String
    public let countryName: String?
}

