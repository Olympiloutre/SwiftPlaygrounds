#  My Custom Vapor Doc 
_( https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet )_

### Vapor Website 
 https://vapor.codes/

### Vapor Tutorials
✓ https://docs.vapor.codes/3.0/getting-started/hello-world/   _( Build and run template )_

✓ https://docs.vapor.codes/3.0/getting-started/toolbox/         _( Templates references )_

✓ https://docs.vapor.codes/3.0/getting-started/routing/          _( Understanding routing )_

✓ https://docs.vapor.codes/3.0/getting-started/controllers/

https://docs.vapor.codes/3.0/getting-started/application/

https://docs.vapor.codes/3.0/getting-started/content/



### SQL Fluent Tutorials

✓ https://docs.vapor.codes/3.0/sqlite/fluent/                               _(Fluent SQLite Doc)_

✓ http://beta.docs.vapor.codes/fluent/query/                              _( Fluent **Query** Tutorial )_

http://beta.docs.vapor.codes/routing/parameters/

http://beta.docs.vapor.codes/fluent/relations/ 


### To See ?
~~http://swiftontheside.com/2016/12/29/simple-rest-api-in-swift-with-vapor/~~ **TOO OLD**

https://medium.com/@azamsharp/look-maa-server-side-swift-using-vapor-638cc3f5a5a8

https://medium.com/@martinlasek/tutorial-how-to-implement-crud-with-vapor-2-f0dd9efef013

https://docs.vapor.codes/3.0/getting-started/spm/


### Testing 

https://medium.com/@martinlasek/tutorial-how-to-write-tests-with-vapor-2-73f600d4ea8b



## Creating Project 

__Prerequisit : HomeBrew Installed__

With command lines : 

    > vapor new Playground_Vapor
    > cd Playground_Vapor
    > vapor build
    > vapor xcode

This will __create__ a new project __build__ it and __create an XCode project__ from it 

From there you can open XCode

## Configuring Git 

A __git reference is already embedded__ in a Vapor Project. This can be a pain if you wnat to add this project into another workspace which is already under revision. 

With command lines : 

    > cd Playground_Vapor
    > rm -rf .git/

This will remove vapor git reference and let you use your root repository

    > cd ..
    > git add *
    > git commit -m "adding vapor"
    > git push origin


## Run

In order to run select the **run** scheme from the scheme menu and **My Mac** as the deployment target, then click the play button.

    Server starting on http://localhost:8080



## SqlLite Example 
https://docs.vapor.codes/3.0/sqlite/fluent/

### 1. Package 

The first step to using Fluent SqlLite is adding it as a dependency to your project in your SPM package manifest file.

    .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0-rc.2")

and 

    .target(name: "App", dependencies: ["FluentSQLite", ...]),

then close and run 

    > vapor xcode
    
_Note: Be sure to do that at the beginning of the project. Runing 'vapor xcode' will recreate the project and thus voiding some references_
_Note 2: Maybe just by using 'vapor build' ?_


### 2. Model 

Creating your model corresponding to your table

_App > Models > MySQLLiteModel.swift_
1. Model 
2. Migration / Content / Parameters


### 3. Configure

The next step is to configure your database. 

_App > configure.swift_
1. Register providers
2. Configure migrations
3. ( Define Router which will manage routes )



### 4. Controllers 

Before linking our Model to a route, we need to configure the expected reaction of the server when it is called. 
For that we create Controllers 

_App > Controllers > MySQLLiteController.swift_
1. Index 
2. Create 
3. Delete 
4. ...

#### Notes on Query : 

    return User.query(on: req).filter(\.age == 17).all()

    return User.query(on: req).group(.and) { and in
        and.filter(\.age < 18)
        and.filter(\.age > 65)
    }.all()


### 5. Routes / Query

Finally let's configure the route query 
_Note : in the configure.swift file we have  'try routes(router)' which basicaly says "register my routes defined inside routes ( routes.swift )". Do not forget it_

_App > routes.swift_
1. Add the new Routes

