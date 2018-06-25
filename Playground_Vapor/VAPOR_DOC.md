#  My Custom Vapor Doc 
_( https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet )_

## Vapor Website 
### https://vapor.codes/

## Vapor Template Used Here
### http://swiftontheside.com/2016/12/29/simple-rest-api-in-swift-with-vapor/

## Creating Project 

__Prerequisit : HomeBrew Installed__

With command lines : 

_> vapor new Playground_Vapor_ 
_> cd Playground_Vapor_ 
_> vapor build_ 
_> vapor xcode_ 

This will __create__ a new project __build__ it and __create an XCode project__ from it 

From there you can open XCode

## Configuring Git 

A __git reference is already embedded__ in a Vapor Project. This can be a pain if you wnat to add this project into another workspace which is already under revision. 

With command lines : 

_> cd Playground_Vapor_
_> rm -rf .git/_

This will remove vapor git reference and let you use your root repository
