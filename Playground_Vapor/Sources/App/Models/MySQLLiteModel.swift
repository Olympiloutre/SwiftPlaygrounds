//
//  MySQLLiteModel.swift
//  App
//
//  Created by Romuald Brochard on 25/06/2018.
//


// Import the Module
import FluentSQLite
import Vapor

/// A simple user.
final class User: SQLiteModel {
    
    /// The unique identifier for this user.
    var id: Int?
    
    /// The user's full name.
    var name: String
    
    /// The user's current age in years.
    var age: Int
    
    /// Creates a new user.
    init(id: Int? = nil, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
}


/// Allows `User` to be used as a migration.
extension User: Migration { }

/// Allows `User` to be encoded to and decoded from HTTP messages.
extension User: Content { }

/// Allows `User` to be used as a dynamic parameter in route definitions. - Otherwise error in routes.swift
extension User: Parameter { }



/*
 
 "The example above shows a SQLiteModel for a simple model representing a user. You can make both structs and classes a model."
 
 "Standard practice with SQLite databases is using an auto-generated INTEGER for creating and storing unique identifiers in the id column. It's also possible to use UUIDs or even Strings for your identifiers. There are convenience protocol for that."
 
 protocol              type      key
 SQLiteModel           Int        id
 SQLiteUUIDModel       UUID       id
 SQLiteStringModel     String     id
 
 

 Migration?
 "All of your models (with some rare exceptions) should have a corresponding table—or schema—in your database. You can use a Fluent → Migration to automatically generate this schema in a testable, maintainable way. Fluent makes it easy to automatically generate a migration for your model"
  "Fluent uses Codable to analyze your model and will attempt to create the best possible schema for it."
 
 Content? Ask Gary
 
 Parameter? Ask Gary
 
 
 
 ( https://docs.vapor.codes/3.0/sqlite/fluent/ )

 */






