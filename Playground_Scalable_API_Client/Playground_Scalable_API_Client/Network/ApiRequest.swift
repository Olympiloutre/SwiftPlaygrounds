// From : https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb

import Foundation

/// All requests must conform to this protocol
/// - Discussion: You must conform to Encodable too, so that all stored public parameters
///   of types conforming this protocol will be encoded as parameters.
public protocol APIRequest: Encodable {
    /// Response
    associatedtype Response: Decodable
    
    /// Endpoint for this request (the last part of the URL)
    var resourceName: String { get }
}

/// Making an alias for callbacks
public typealias ResultCallback<Value> = (Result<Value, Error>) -> Void
