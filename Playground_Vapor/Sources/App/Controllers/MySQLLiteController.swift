//
//  MySQLLiteController.swift
//  App
//
//  Created by Romuald Brochard on 26/06/2018.
//
// Sources :
//  http://beta.docs.vapor.codes/fluent/query/
//  http://beta.docs.vapor.codes/routing/parameters/

// import Foundation
import Vapor
import FluentSQLite



/// Controls operations on `User`s.
final class UserController {
    
    
    
    /*
     
                    Gathering Params
    
    ex request :
        url : http://localhost:8080/users
        method : GET
        param :
            name : Romuald
            age : 17
    
    let name = req.query[String.self, at: "name"]
    print(name)            // > Optional("Romuald")
    
    let age = req.query[Int.self, at: "age"]
    print(age)             // > Optiuonal(17)
    
    let missing_param = req.query[Int.self, at: "missing_param"]
    print(missing_param)  // > nil
    
    
     
    ( And or sub values )
    let name = req.query[String.self, at: "user", "name"]
    
    
    */
    
    
    
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
    /*
     EXAMPLES :
     Source :  http://beta.docs.vapor.codes/fluent/query/
     
            1. Simple filter
     
     return User.query(on: req).filter(\.name == "Romuald").all()
     return User.query(on: req).filter(\.age == 17).all()
     return User.query(on: req).filter(\.id == 17).all()
     return User.query(on: req).filter(\.unknown_attribute == 17).all()
     // -> ERROR unknown_attribute "Type of expression is ambiguous without more context"
     
     
     
            2. Complex Filter (query.group(...))
     
        a. -- AND --
     
     return User.query(on: req).filter(\.name == "Romuald").filter(\.age == 17).all()
     
     return User.query(on: req).group(.and) { and in
         and.filter(\.age < 18)
         and.filter(\.age > 65)
     }.all()
     
     
        b. -- OR --
     
     return User.query(on: req).group(.or) { or in
         or.filter(\.age > 18)
         or.filter(\.age < 65)
     }.all()
     
     */
    
    // Filter that search for 'name' and/or 'age' parameter to filter 'user's base
    // if none : get all -> Index is deprecated
     func filter(_ req: Request) throws -> Future<[User]> {
        
        let parameter_name = req.query[String.self, at: "name"]
        let parameter_age = req.query[Int.self, at: "age"]
        
        return User.query(on: req).group(.and) { and in
            
            
                // if name parameter found
                if let _ = parameter_name {
                    and.filter(\.name == parameter_name!)
                }
            
                // if age parameter found
                if let _ = parameter_age {
                    and.filter(\.age == parameter_age!)
                }
            
                and.filter(true)
            
            }.all()
        
    }
    
    // TODO : raw SQL Queries
    // TODO sort
    // TODO update
    // TODO drop
    // TODO : Errors / Aborts https://medium.com/@martinlasek/tutorial-how-to-implement-crud-with-vapor-2-f0dd9efef013
    

}
