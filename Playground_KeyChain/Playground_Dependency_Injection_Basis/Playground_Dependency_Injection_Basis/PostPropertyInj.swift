//
//  File.swift
//  Playground_Dependency_Injection_Basis
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//

/*
 
            PROPERTY INJECTION
 
 Sometimes initializer injection is hard to do, because your class have to inherit from a system class.
 This makes the process really hard if you have to work with views or controllers.
 A good solution for this situation is to use a property-based injection design pattern.
 
 Maybe you can't have full control over initialization, but you can always control your properties.
 The only disadvantage is that you have to check if that property is already presented (being set) or not, before you do anything with it. 🤫
 
 */

import Foundation

class PostPropertyInj: Encodable {
    
    var title: String
    var content: String
    
    var encoder: Encoder? // 1 - property set as optional - need to be set after init
    
    private enum CodingKeys: String, CodingKey {
        case title
        case content
    }
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    func encoded() throws -> Data {
        guard let encoder = self.encoder else { // 2 -"The only disadvantage is that you have to check if that property is already presented"
            fatalError("Encoding is only supported with a valid encoder object.")
        }
        return try encoder.encode(self)
    }
    
}

/*
 
 let post = PostPropertyInj(title: "Hello DI!", content: "Property injection")
 post.encoder = JSONEncoder()
 
 if let data = try? post.encoded(), let encoded = String(data: data, encoding: .utf8) {
    print(encoded)
 }
 */
