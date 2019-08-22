# guides-ios
Coding challenge for listing guides

<!-- ## Setup

Developed with `Xcode Version 10.3 (10G8)`

This project uses [Carthage](https://github.com/Carthage/Carthage)<sup>*</sup>. To install dependencies use:
```
carthage bootstrap --platform iOS
```
> *I pesonaly don't like Cocoapods Workspace magics, also I feel that Carthage is more safe<sup>**</sup> and transparent.
> ** With cocoapods any dependency has the ability to run randon scripts described on the Podspec.


## Dependencies

[Kingfischer](https://github.com/onevcat/Kingfisher)
> Image loading and caching, used for icons on cells.I choose Kingfischer because it has less issues and more recent commits when compared with [Haneke](https://github.com/Haneke/HanekeSwift)

 
## Architecture

- It's a small project so I decided to go with Apples's MVC, just with separation of the cell.
- Created a simple networking layer, usign URLSession and the power og Swift Codable for object mapping.
- This approach allows for mock json files
- Using ApiRoute, we centralize all the API routes that might be called in the Facades
-->