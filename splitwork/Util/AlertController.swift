//
//  AlertController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/23/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class Util {
    
    static func showSuccessMessage(_ viewController: UIViewController, _ message: String) {
        let alert = UIAlertController(title: "Success: ", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showErrorMessage(_ viewController: UIViewController, _ message: String) {
        let alert = UIAlertController(title: "Error: ", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
