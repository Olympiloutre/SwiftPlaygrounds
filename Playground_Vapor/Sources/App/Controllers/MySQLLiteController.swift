//
//  MySQLLiteController.swift
//  App
//
//  Created by Romuald Brochard on 26/06/2018.
//
// ( http://beta.docs.vapor.codes/fluent/query/ )

// import Foundation
import Vapor
import FluentSQLite

/// Controls operations on `User`s.
final class UserController {
    
    /// Returns a list of all `User`s.
    func index(_ req: Request) throws -> Future<[User]> { // ( return a list of User )
        return User.query(on: req).all()
    }
    
    /// Saves a decoded `User` to the database.
    func create(_ req: Request) throws -> Future<User> { // ( and return a siumple User )
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }
    
    /// Deletes a parameterized `User`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> { // ( return an HTTP Status )
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
            }.transform(to: .ok)
    }
    
    /// Get 'User' by ID
    func getUser(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    
    /// Filter
    /// Source :  http://beta.docs.vapor.codes/fluent/query/
    ///     ... try query.filter("age", .greaterThanOrEquals, 21) ...
    ///
    
    func filter(_ req: Request) throws -> Future<[User]> {
        
        /*
         EXAMPLES :
         
         1. Simple filter
        
          return User.query(on: req).filter(\.name == "Romuald").all()
        
          return User.query(on: req).filter(\.age == 17).all()
        
          return User.query(on: req).filter(\.id == 17).all()
        
          return User.query(on: req).filter(\.unknown_attribute == 17).all() // ERROR "Type of expression is ambiguous without more context"
        
         
         2. Complex Filter (query.group(...))
        
            a. AND
         
          return User.query(on: req).filter(\.name == "Romuald").filter(\.age == 17).all()
        
          return User.query(on: req).group(.and) { and in
              and.filter(\.age < 18)
              and.filter(\.age > 65)
          }.all()
         
        
            b. OR
         
          return try User.query(on: conn).group(.or) { or in
                 or.filter(\.age > 18)
                 or.filter(\.age < 65)
             }.all()
         
        */
        
        return User.query(on: req).group(.and) { and in
            and.filter(\.age > 18)
            and.filter(\.age < 65)
        }.all()
        
        
    }
    
    
    // TODO sort
    // TODO update

}
