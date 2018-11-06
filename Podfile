# Pod global to Workspace with multiple Projects
# sources :
# - https://medium.com/@youvalv/cocoapods-for-an-existing-multi-project-workspace-1fb73f46fede 
# - https://stackoverflow.com/questions/22295833/how-to-add-cocoapods-to-existing-workspace-not-project


# 1. `Touch Podfile` on PlaygroundsWorkspace.xcworkspace
#
# 2. Edit Podfile :
#
#   a. set `workspace 'PlaygroundsWorkspace'`
#   b. set `project 'Playground_Graphics/Playground_Graphics.xcodeproj'` for all projects
#   c. add targets
#   d. insite targets specify the concerned `project`
#
# 3. pod install
#
# 4. ( close & reopen XCode, clean and build )


# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

workspace 'PlaygroundsWorkspace'
project 'Playground_Graphics/Playground_Graphics.xcodeproj'

target 'Playground_Graphics' do
	project 'Playground_Graphics/Playground_Graphics.xcodeproj'
	pod 'lottie-ios'
end
