import FluentSQLite
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    
    /// Register routes to the router ( https://docs.vapor.codes/3.0/getting-started/routing/ )
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    
    
    
    /// --- SQL Lite Related ---
    
    /// Register providers first -
    // "add all of the services required for Fluent SQLite to work + default DB config."
    try services.register(FluentSQLiteProvider())
    
    // Configure a SQLite database
    // let sqlite = try SQLiteDatabase(storage: .memory)
    let sqlite = try SQLiteDatabase(storage: .file(path: "MySQLiteDB.sqlite")) // persistent

    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)
    
    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .sqlite) // User from 'MySQLLiteModel' example
    services.register(migrations)
    

}
