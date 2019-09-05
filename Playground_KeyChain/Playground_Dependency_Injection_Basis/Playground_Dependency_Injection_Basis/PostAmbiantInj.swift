//
//  File3.swift
//  Playground_Dependency_Injection_Basis
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//

/*
 
    AMBIANT CONTEXT INJECTION
 
 Our last pattern is quite a dangerous one. It should be used only for universal dependencies that are being shared alongside multiple object insatnces.
 Logging, analytics or a caching mechanism is a good example for this. 🚧

 
 */

import Foundation

class PostAmbiantInj: Encodable {
    
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    func encoded() throws -> Data {
        return try Post.encoder.encode(self)
    }
    
    private static var _encoder: Encoder = PropertyListEncoder()
    
    static func setEncoder(_ encoder: Encoder) {
        self._encoder = encoder
    }
    
    static var encoder: Encoder {
        return Post._encoder
    }
}


/*
let post = Post(title: "Hello DI!", content: "Ambient context")
Post.setEncoder(JSONEncoder())

if let data = try? post.encoded(), let encoded = String(data: data, encoding: .utf8) {
    print(encoded)
}
*/ 
