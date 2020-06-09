//
//  Weather.swift
//  MVVM_RxSwift
//
//  Created by Romuald Brochard on 30/4/19.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//
// eg: http://api.openweathermap.org/data/2.5/weather?q=London&appId=efbe98e55bd369e345fdf3319a32e1cf

import Foundation

public struct Location: Codable {
    public let id: Int
    public let cod: Int
    public let name: String
    public let base: String
    public let visibility: Int?
    public let weather: [Weather]
    public let main: Main
    public let coord: Coord
    
    public func iconUrl() -> String? {
        guard let icon = weather.first?.icon else { return nil }
        return "http://openweathermap.org/img/w/\(icon).png"
    }
}

public struct Coord: Codable {
    public let lon: Double
    public let lat: Double
}

public struct Weather: Codable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}

public struct Main: Codable {
    public let temp: Double
    public let pressure: Double
    public let humidity: Int
    public let tempMin: Double
    public let tempMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
