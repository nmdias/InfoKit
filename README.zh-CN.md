
![InfoKit](/InfoKit.png?raw=true)

[![cocoapods compatible](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg)](https://cocoapods.org/pods/InfoKit)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![language](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org)
[![swift](https://img.shields.io/badge/swift-4-orange.svg)](https://github.com/nmdias/InfoKit/releases)

[English](README.md)

基于Swift 4强大的[Codable](https://developer.apple.com/documentation/swift/codable)新特性, 在短短60行代码内InfoKit即可提供**Info.plist**文件的**强类型**访问.

安装 >> [`安装说明`](https://github.com/nmdias/InfoKit/blob/master/INSTALL.md) <<

## 使用

首先根据项目bundle中**Info.plist**文件的属性类型, 定义[Codable](https://developer.apple.com/documentation/swift/codable)协议的结构体.

```swift
struct Info: Codable {
    let baseUrl: String
    let staticUrl: String
}
```

然后读取Info.plist到该`Info`结构体:
```swift
// Define a Plist
let plist = Plist<Info>()

// Decode it
let info = plist.decode()

// Then access it's properties
info?.baseUrl    // http://debug.InfoKit.local
info?.staticUrl  // http://debug.static.InfoKit.local
```

### 自定义.plist
为了方便性, `InfoKit`也提供对自定义.plist文件的支持. 假设已经导入**ProductIDs.plist**文件. 开始根据属性类型定义结构体.

```swift
struct Products: Codable {
    let foo: String
    let bar: String
}
```
定义`Plist`, 并**指定文件名** 例如: `ProductIDs`

```swift
let plist = Plist<Products>("ProductIDs") // Reads `ProductIDs.plist`
let products = plist.decode()

products?.foo // com.InfoKit.foo
products?.bar // com.InfoKit.bar

```

> 注意! 用户提供的文件列表必须复制到Bundle, 所以确保设置成`Target Membership`.

### 自定义Bundle
InfoKit默认使用[Main Bundle](https://developer.apple.com/documentation/foundation/bundle/1410786-main), 但是如果需要可以使用**自定义Bundle**:

```swift
Plist<Products>("ProductIDs", in: bundle)
```

### 配置构建
当初始化`Plist`时, 如果**没有Plist名或者没有Bundle名**, 如:

```swift
Plist<Info>()
```

`InfoKit` 将会默认使用Main Bundle中的Info.plist文件来配置构建.

因为该特征, 你可以使用**多个Info.plist**文件来进行**不同的配置**仍然有预期的结果.
在example中, 你可以通过在配置选项**debug**, **staging**和**release**之间切换看到该结果.

### 开源协议

InfoKit在MIT许可下发布. 详见[LICENSE](https://github.com/nmdias/InfoKit/blob/master/LICENSE).
