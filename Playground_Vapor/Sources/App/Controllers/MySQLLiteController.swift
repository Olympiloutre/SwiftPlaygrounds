//
//  MySQLLiteController.swift
//  App
//
//  Created by Romuald Brochard on 26/06/2018.
//

// import Foundation
import Vapor

/// Controls operations on `User`s.
final class UserController {
    
    /// Returns a list of all `User`s.
    func index(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    /// Saves a decoded `User` to the database.
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }
    
    /// Deletes a parameterized `User`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
            }.transform(to: .ok)
    }
    
}
