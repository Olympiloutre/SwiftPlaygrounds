//
//  File.swift
//  Playground_Dependency_Injection_Basis
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//


/*
 
            CONSTRUCTOR INJECTION
 
 The most common form of dependency injection is constructor injection or initializer-based injection.
 The idea is that you pass your dependency through the INITIALIZER and store that object inside a (private read-only / immutable) property variable.
 The main benefit here is that your object will have every dependency - by the time it's being created - in order to work properly.
 
 */

import Foundation

class PostConstructor: Encodable {
    
    // Encodable part
    var title: String
    var content: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case content
    }
    
    private var encoder: Encoder // 1 - not optional - set during init (constructor)
    
    init(title: String, content: String, encoder: Encoder) { // 2 - injecting the dependency ( encoder ) in init
        self.title = title
        self.content = content
        self.encoder = encoder // 2 - here
    }
    
    func encoded() throws -> Data {
        return try self.encoder.encode(self) // 3 - using here
    }
}

/* 
 
 let post = PostConstructor(title: "Hello DI!", content: "Constructor injection", encoder: JSONEncoder())
 
 if let data = try? post.encoded(), let encoded = String(data: data, encoding: .utf8) {
    print(encoded)
 }
 
 
 */
