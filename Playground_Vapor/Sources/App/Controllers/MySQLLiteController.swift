//
//  MySQLLiteController.swift
//  App
//
//  Created by Romuald Brochard on 26/06/2018.
//
// Sources :
//  http://beta.docs.vapor.codes/fluent/query/
//  http://beta.docs.vapor.codes/routing/parameters/
//  https://medium.com/@martinlasek/tutorial-how-to-implement-crud-with-vapor-2-f0dd9efef013
//
// import Foundation
import Vapor
import FluentSQLite



/// Controls operations on `User`s.
final class UserController {
    
    
    
    /*
     
                    Gathering Params
     
       ---  !! GET ONLY !!  ---
     
     
     
    Parameters are passed in URL only in GET !!
     This method won't work for other methods which have their parameters passed in body ( ~> decode )
     
     
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
     
     NOTE : This method for gathering parameters is ONLY available IN POST
     
     
     --- !! POST, PUT et autre !! ---
     
     In POST / PUT you have to decode the body. This implies the body contains ÀLL the User's parameters but it's not an issue..
     
     Note Gary : " ce n'est pas grave car dans la méthodio rest, dans un premier temps tu récupère ton objet entier via un GET, tu le modifie et tu le renvoi entièrement au serveur"
    
     ...
     return try req.content.decode(User.self).flatMap { user in
     ...
    
    */
    
    
    
    
    /// Returns a list of all `User`s. - deprecated since 'users' filter - see below
    @available(*, deprecated)
    func index(_ req: Request) throws -> Future<[User]> { // ( return a list of User )
        return User.query(on: req).all()
    }
    
    
    /// Saves a decoded `User` to the database. ( POST so 'decode' body parameters )
    func create(_ req: Request) throws -> Future<User> { // ( and return a simple User )
        
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
    
    
    
    /// Update 'User' by ID
    /*
     
     Reminder : in PUT, parameters are passed in body
     
     1. we decode the new user (updated_user) , which parameters are passed inside the body of the PUT request
     2. we find the user to update ( old_user )
     3. we copy the new values inside old user
     4. we save
     
     
     *Decoding implies that all the parameters are passed inside the body. Otherwise an error is thown considering a User was not created due to missing params.
     
     */
    func updateUser(_ req: Request) throws -> Future<User> {

        return try req.content.decode(User.self).flatMap { updated_user in  // 1.
            return try req.parameters.next(User.self).flatMap { old_user in // 2.
                old_user.name = updated_user.name // 3.1
                old_user.age = updated_user.age   // 3.2
                
                return old_user.save(on: req) // 4.
            }
        }
        

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

        if parameter_age == nil && parameter_name == nil {
            return User.query(on: req).all()
        }
        
        return User.query(on: req).group(.and) { and in
            
                // if name parameter found
                if let _ = parameter_name {
                    and.filter(\.name == parameter_name!)
                }
            
                // if age parameter found
                if let _ = parameter_age {
                    and.filter(\.age == parameter_age!)
                }
            
            }.sort(\.name, .ascending)
            .all()
        
    }
    

}
