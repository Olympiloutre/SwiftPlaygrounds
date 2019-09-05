//
//  GetGeoNames.swift
//  MVVM_RxSwift
//
//  Created by Romuald Brochard on 2/5/19.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//

import Foundation

public struct GetGeoNames: APIRequest {
    public typealias Response = GeoNames
    
    // Notice how we create a composed resourceName
    /// return "comics/\(comicId)"
    public var resourceName: String {
        return "searchJSON"
    }
    
    // must be the same name than the parameters of the querry...
    private let querry: String?
    private let maxRows: Int?

    // ... or using CodingKeys if the name of the variable is different from the name of the URL parameter
    private enum CodingKeys: String, CodingKey {
        case maxRows
        case querry = "q"
    }
    
    public init(querry: String? = nil,
                maxRows: Int? = 5) {
        
        self.querry = querry
        self.maxRows = maxRows
    }
}


