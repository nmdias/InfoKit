
![InfoKit](/InfoKit.png?raw=true)

[![cocoapods compatible](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg)](https://cocoapods.org/pods/InfoKit)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![language](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org)
[![swift](https://img.shields.io/badge/swift-4-orange.svg)](https://github.com/nmdias/InfoKit/releases)

[简体中文](README.zh-CN.md)

InfoKit provides **Strongly Typed** access to the **Info.plist** with less than 60 lines of code, while leveraging **Swift 4**'s powerful [Codable](https://developer.apple.com/documentation/swift/codable) capabilities.

Installation >> [`instructions`](https://github.com/nmdias/InfoKit/blob/master/INSTALL.md) <<

## Usage

Define a [Codable](https://developer.apple.com/documentation/swift/codable) with the properties you wish to access from the project's bundle **Info.plist** file.

```swift
struct Info: Codable {
    let baseUrl: String
    let staticUrl: String
}
```

And read the Info.plist into the `Info` struct:
```swift
// Define a Plist
let plist = Plist<Info>()

// Decode it
let info = plist.decode()

// Then access it's properties
info?.baseUrl    // http://debug.InfoKit.local
info?.staticUrl  // http://debug.static.InfoKit.local
```

### Build Configurations
 If **no resource or bundle is specified** in the initializer of the `Plist` class, then `InfoKit` will default to the Main Bundle's Info.plist file defined in the Project's Build Settings.

```swift
init(_ resource: String? = nil, in bundle: Bundle = Bundle.main)
```

 Because of this, you can provide multiple Info.plist files for different configurations and still get the desired results. See the provided iOS Example project in action.


### Custom .plist
For convenience, `InfoKit` will also provide access to custom .plist files. Let's say you included a **ProductIDs.plist** file. Start by defining the struct with it's respective properties.

```swift
struct Products: Codable {
    let foo: String
    let bar: String
}
```

Define a `Plist`, and this time, **specify the resource name**. e.g. `ProductIDs`

```swift
let plist = Plist<Products>("ProductIDs") // Reads `ProductIDs.plist`
let products = plist.decode()

products?.foo // com.InfoKit.foo
products?.bar // com.InfoKit.bar

```

> Remember, user provided property lists must be copied into the bundle, so make sure to set it's `Target Membership`.

### Specify a Bundle
InfoKit will default to the [Main Bundle](https://developer.apple.com/documentation/foundation/bundle/1410786-main), however, you can **specify the bundle**, if needed:

```swift
Plist<Products>("ProductIDs", in: bundle)
```

## License

InfoKit is released under the MIT license. See [LICENSE](https://github.com/nmdias/InfoKit/blob/master/LICENSE) for details.

### Help Wanted
#### Review/Translate [README.zh-CN.md](README.zh-CN.md) to Chinese
Chinese is the #1 spoken language in the world and I'd love to have InfoKit be more inclusive, unfortunately I don't speak Chinese. If you know chinese, and would like to help out, please see [issue #1](https://github.com/nmdias/InfoKit/issues/1)

Thank you 🙏
