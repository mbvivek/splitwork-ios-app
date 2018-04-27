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
    
    static func convertImageToBase64(image: UIImage) -> String {
        let imageData = UIImagePNGRepresentation(image)
        //let base64String = imageData.base64EncodedStringWithOptions(.allZeros)
        let base64String = imageData?.base64EncodedData()
        return String(data: base64String!, encoding: String.Encoding.utf8)!
    }
    
    static func convertBase64ToImage(base64String: String) -> UIImage {
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        let decodedimage = UIImage(data: decodedData! as Data)
        return decodedimage!
    }
    
    static func jsonString(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    static func isInteger(testString:String) -> Bool {
        return (Int(testString) != nil)
    }
    
    static func isDouble(testString:String) -> Bool {
        return (Double(testString) != nil)
    }
    
    static func isValidEmail(testEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let valid:Bool = emailTest.evaluate(with: testEmail)
        print("testEmail = \(testEmail), \(valid)")
        return valid
    }
    
    static func isValidPhone(testPhone: String) -> Bool {
        let phoneRegEx = "^\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        let valid:Bool = phoneTest.evaluate(with: testPhone)
        print("testPhone = \(testPhone), \(valid)")
        return valid
    }
    
    static func isValidZip(testZip: String) -> Bool {
        let zipRegEx = "^\\d{5}$"
        let zipTest = NSPredicate(format: "SELF MATCHES %@", zipRegEx)
        let valid:Bool = zipTest.evaluate(with: testZip)
        print("testZip = \(testZip), \(valid)")
        return valid
    }
    
}
