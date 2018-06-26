import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    
    // on navigator : http://localhost:8080/users
    router.get("hello") { req in
        return "Hello, world!"
    }

    

    // --- SQLite Example ---
    
    // All action placed inside a Controller
    let userController = UserController()
    
    // GET : on navigator or on HTTP Client
    /// http://localhost:8080/users
    /// Method : GET
    /// Parameters : none
    router.get("users", use: userController.index)
    
    
    // POST : on HTTP Client
    /// http://localhost:8080/users
    /// Method : POST
    /// Parameters :
    ///   name : Romuald
    ///   age : 20
    router.post("users", use: userController.create)

    
    
    // DELETE : on HTTP Client
    /// http://localhost:8080/users/1 ( users/ID_USER )
    /// Method : DELETE
    /// Parameters : none
    router.delete("users", User.parameter, use: userController.delete)

    
}
