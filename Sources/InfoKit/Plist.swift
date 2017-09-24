//
//  Config.swift
//
//  Copyright (c) 2017 Nuno Manuel Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

/// Represents a `Plist` with an associated generic value type conforming to the
/// `Codable` protocol.
///
///     static let someKey = Plist<T>(resource, in: bundle)
public class Plist<T: Codable> {
    
    fileprivate let resource: String?
    fileprivate let bundle: Bundle
    
    /// Property list definition.
    ///
    /// - Parameters:
    ///   - resource: The property list resource's file name.
    ///   - bundle: The bundle.
    public init(_ resource: String? = nil, in bundle: Bundle = Bundle.main) {
        self.resource = resource
        self.bundle = bundle
    }
    
    /// Returns the value associated with the specified plist. If the `Plist`'s
    /// resource name is not specified it will default to the default bundled
    /// Info.plist file.
    ///
    /// - Parameter plist: The Plist provider
    /// - Returns: A instance of `T` or nil if the resource was not found or failed to decode.
    public func decode() -> T? {
        guard let resource = self.resource else {
            return getFromBundledInfo()
        }
        
        guard let path = self.bundle.path(forResource: resource, ofType: "plist", inDirectory: nil) else {
            #if DEBUG
                print("Resource: \(resource) not found in bundle: \(self.bundle)")
            #endif
            return nil
        }
        
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            #if DEBUG
                print(error)
            #endif
        }
        
        return nil
        
    }
    
    /// Returns the value associated with the default bundled Info.plist file.
    ///
    /// - Parameter plist: The Plist provider
    /// - Returns: A instance of `T` or nil if the resource was not found or failed to decode.
    private func getFromBundledInfo() -> T? {
        guard let infoDictionary = self.bundle.infoDictionary else {
            #if DEBUG
                print("infoDictionary for bundle: \(self.bundle) is nil.")
            #endif
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: infoDictionary)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            #if DEBUG
                print(error)
            #endif
        }
        
        return nil
        
    }
    
}
