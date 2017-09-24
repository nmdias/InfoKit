//
//  ViewController.swift
//  Example
//
//  Created by Nuno Dias on 24/09/2017.
//  Copyright © 2017 Nuno Dias. All rights reserved.
//

import UIKit
import InfoKit

struct Info: Codable {
    let baseUrl: String
    let staticUrl: String
}

struct Products: Codable {
    let foo: String
    let bar: String
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printBuildConfigurationUrls()
        printProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert()
    }

    /// Prints the App's Info.plist of the current build configuration
    private func printBuildConfigurationUrls() {
        let plist = Plist<Info>()
        let info = plist.decode()!
        
        print("\nurls")
        print(info.baseUrl)
        print(info.staticUrl)
        
    }
    
    /// Prints the user provided `Products.plist`.
    ///
    /// Remember, user provided property lists must be copied into the bundle.
    /// Make sure to set it's `Target Membership`
    private func printProducts() {
        let plist = Plist<Products>("Products")
        let products = plist.decode()!
        
        print("\nproducts")
        print(products.foo)
        print(products.bar)
        
    }
    
    func showAlert() {
        let message = "It's all in the console 😃"
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

