# guides-ios
Coding challenge for listing guides

## Setup

Developed with `Xcode Version 10.3 (10G8)`
 
## Design Pattern
It's a small project so I decided to go with a variation of **Apple's MVC**, this approach reduces boilerplate code and keeps code easy to follow. I also decided to use `Interface Builder` instead of view code because it's faster to prototype and I had to make design decisions on the go.

#### Dependencies
I did not need any dependecy due to the simplicity of the project, but if I need one, my first choice of dependency manager is **Cartage** mainly because I feel that it is safer when compared with CocoaPods because CocoaPods with its workspace allows any dependency to include scripts on build steps.

#### Networking
- Created a simple networking layer, using `URLSession` and `Swift Codable` for object mapping, that allows mocking responses.
- Using ApiRoute to centralize all the API routes that might be called in the Facades.

###### Adding new route
To add a new route you need to fallow the steps below
1. Add a case on `ApiRoute.swift` including its `url`, `method`, and `mockFilePath`.
1. If needed create the `Response` model that represents the server response.
1. Create a func on a Facade that represents the resource `or` create a new Facade.

#### Code style
- Using class extensions to separate protocol conformations, this is not optimal in terms of compilation time. For large projects, I would go with the `//MARK: - ` approach for this separation
- Configure tableView in code to avoid hidden IB configurations.

## Improvments

- [ ] Better Error handling for failed requests