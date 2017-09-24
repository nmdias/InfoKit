//
//  ConfigTests.swift
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

import XCTest
@testable import InfoKit

class ConfigTests: XCTestCase {
    
    var config: Config!

    override func setUp() {
        super.setUp()
        self.config = Config()
    }
    
    override func tearDown() {
        super.tearDown()
        self.config = nil
    }
    
    func testInfoPlist() {
        
        // Mocks
        struct Info: Codable {
            let baseUrl: String
            let staticUrl: String
        }
        
        // Given
        let bundle = Bundle(for: ConfigTests.self)
        let plist = Plist<Info>(in: bundle)
        
        // When
        let info = config.get(plist)
        
        // Then
        #if DEBUG
        XCTAssertEqual(info?.baseUrl, "http://debug.InfoKit.local")
        XCTAssertEqual(info?.staticUrl, "http://debug.static.InfoKit.local")
        #endif
        
    }
    
    func testUserProvidedPlist() {
        
        // Mocks
        struct Products: Codable {
            let foo: String
            let bar: String
        }
        
        // Given
        let bundle = Bundle(for: ConfigTests.self)
        let plist = Plist<Products>("Products", in: bundle)
        
        // When
        let products = config.get(plist)

        // Then
        XCTAssertEqual(products?.foo, "com.InfoKit.foo")
        XCTAssertEqual(products?.bar, "com.InfoKit.bar")

    }
    
}
