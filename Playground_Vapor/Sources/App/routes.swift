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
    // get all users
    /// http://localhost:8080/index
    /// Method : GET
    /// Parameters : none
    router.get("index", use: userController.index)
    
    
    // POST : on HTTP Client
    // create one user
    /// http://localhost:8080/users
    /// Method : POST
    /// Parameters :
    ///   name : Romuald
    ///   age : 20
    router.post("user", use: userController.create)

    
    // DELETE : on HTTP Client
    // delete user using it's ID
    /// http://localhost:8080/user/1 ( users/ID_USER )
    /// Method : DELETE
    /// Parameters : none
    router.delete("user", User.parameter, use: userController.delete)
    
    
    
    
    // GET : on navigator or on HTTP Client
    // get a user by ID
    /// http://localhost:8080/user/1
    /// Method : GET
    /// Parameters : none
    router.get("user", User.parameter, use: userController.getUser)
 
    
    
    // GET : on navigator or on HTTP Client
    // get all with age matching
    /// http://localhost:8080/users
    /// Method : GET
    /// Parameters :
    ///   age : 20
    /// && ||
    ///   name : Romuald
    router.get("users", use: userController.filter)
    
    
}
