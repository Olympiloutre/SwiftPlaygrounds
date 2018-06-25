import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // Basic "Hello, world!" example ( http://localhost:8080/hello )
    router.get("hello") { req in
        return "Hello, world!"
    }


    router.get("users") { req in
        return User.query(on: req).all()
    }
    
    
    /*
    let userController = UserController()
    router.get("users", use: userController.getAll)
 */
    
    /* TO UNDERSTAND
     // Previous example of configuring a controller
     let todoController = TodoController()
     router.get("todos", use: todoController.index)
     router.post("todos", use: todoController.create)
     router.delete("todos", Todo.parameter, use: todoController.delete)
     */
    
}
