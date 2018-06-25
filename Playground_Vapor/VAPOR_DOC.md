#  My Custom Vapor Doc 
_( https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet )_

### Vapor Website 
 https://vapor.codes/

### Official Tutorials
✓ https://docs.vapor.codes/3.0/getting-started/hello-world/   _( Build and run template )_

✓ https://docs.vapor.codes/3.0/getting-started/toolbox/         _( Templates references )_

https://docs.vapor.codes/3.0/mysql/fluent/ _(MySQL Doc)_

### Other
~~http://swiftontheside.com/2016/12/29/simple-rest-api-in-swift-with-vapor/~~ **TOO OLD**

https://docs.vapor.codes/3.0/getting-started/spm/


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



## MySQL Example 

### 1. Package 

The first step to using Fluent MySQL is adding it as a dependency to your project in your SPM package manifest file.

    .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.0-rc"),

and 

    .target(name: "App", dependencies: ["FluentMySQL", ...]),

then close and run 

    > vapor xcode
    


