//
//  File2.swift
//  Playground_Dependency_Injection_Basis
//
//  Created by Romuald Brochard on 13/04/2019.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//

/*
 
                METHOD INJECTION
 
 If you need a dependency only once, you don't really need to store it as an object variable.
 Instead of an initializer argument or an exposed mutable property, you can simply pass around your dependency as a method parameter, this technique is called method injection or some say parameter-based injection. 👍
 
 */

import Foundation

class PostMethodInj: Encodable {
    
    var title: String
    var content: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case content
    }
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    func encode(using encoder: Encoder) throws -> Data { // 1 - passing the dependency ( encoder ) inside method
        return try encoder.encode(self)
    }
}


/*
let post = PostMethodInj(title: "Hello DI!", content: "Method injection")

if let data = try? post.encode(using: JSONEncoder()), let encoded = String(data: data, encoding: .utf8) {
    print(encoded)
}
*/
