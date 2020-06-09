//
//  ApiClient.swift
//  MVVM_RxSwift
//
//  Created by Romuald Brochard on 2/5/19.
//  Copyright © 2019 Romuald Brochard. All rights reserved.
//
// [weak self] in protocol extensiosn
// https://medium.com/@superpeteblaze/referencing-a-weak-self-in-swift-protocol-extensions-3e4a7c2ed26d

import Foundation

// "'weak' must not be applied to non-class-bound 'Self'; consider adding a protocol conformance that has a class bound"
// solution -> ':class'
protocol ApiClient: class {
    
    var baseEndpointUrl: URL { get }
    var session: URLSession { get }
    var commonQueryItems: [URLQueryItem] { get }
    
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>)
    func endpoint<T: APIRequest>(for request: T) -> URL
}

extension ApiClient {
    
    /// Sends a request to servers, calling the completion method when finished
    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        let endpoint = self.endpoint(for: request)
        
        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    let rep = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(rep))
                    
                } catch let err {
                    completion(.failure(err))
                }
                
            } else if let error = error {
                completion(.failure(error))
                return
            }
        }
        task.resume()
    }
    
    /// Encodes a URL based on the given request
    /// Everything needed for a public request to Marvel servers is encoded directly in this URL
    func endpoint<T: APIRequest>(for request: T) -> URL {
        guard let baseUrl = URL(string: request.resourceName, relativeTo: baseEndpointUrl) else {
            fatalError("Bad resourceName: \(request.resourceName)")
        }
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        
        // Common query items needed for all Marvel requests
        let commonQueryItems = self.commonQueryItems
        
        // Custom query items needed for this specific request
        let customQueryItems: [URLQueryItem]
        
        do {
            customQueryItems = try URLQueryItemEncoder.encode(request)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }
        
        components.queryItems = commonQueryItems + customQueryItems
        
        // Construct the final URL with all the previous data
        return components.url!
    }
}
