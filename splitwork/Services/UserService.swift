//
//  UserService.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class UserService {
    
    let httpService: HTTPService
    
    private static var sharedService: UserService = {
        let service = UserService()
        return service
    }()
    
    private init() {
        self.httpService = HTTPService.shared()
        print("UserService initialized..")
    }
    
    class func shared() -> UserService {
        return sharedService
    }
    
    func syncUsers() {
        User.shared.clear()
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in UserService.syncUsers()")
            } else {
                guard let users = data["data"] as? [[String:Any]] else {
                    print("Error parsing users to [[String:Any]] in UserService.syncUsers()")
                    return
                }
                for user in users {
                    let id = user["id"] as! String
                    let username = user["username"] as! String
                    let password = user["password"] as! String
                    let name = user["name"] as! String
                    let email = user["email"] as! String
                    let phone = user["phone"] as! String
                    let profilePic = Util.convertBase64ToImage(base64String: user["profilePic"] as! String)
                    
                    var groupIds = [String]()
                    if let _groupIds = user["groupIds"] as? [String] {
                        groupIds = _groupIds
                    } else {
                        print("Error parsing groups to [String] in UserService.syncUsers()")
                    }
                    
                    User.shared.addUser(id: id, username: username, password: password, name: name, email: email, phone: phone, profilePic: profilePic, groupIds: groupIds)
                    
                    if let _creditCard = user["creditCard"] as? [String: Any] {
                        let ccId = _creditCard["id"] as! String
                        let ccNumber = _creditCard["number"] as! String
                        let ccNameOnCard = _creditCard["nameOnCard"] as! String
                        let ccExpiryMonth = _creditCard["expiryMonth"] as! String
                        let ccExpiryYear = _creditCard["expiryYear"] as! String
                        let ccCvv = _creditCard["cvv"] as! String
                        let ccZip = _creditCard["zip"] as! String
                        let ccType = _creditCard["type"] as! String
                        User.shared.addCreditCardToUser(username: username, id: ccId, number: ccNumber, nameOnCard: ccNameOnCard, expiryMonth: ccExpiryMonth, expiryYear: ccExpiryYear, cvv: ccCvv, zip: ccZip, type: ccType)
                    } else {
                        print("Error parsing creditCard to [String:Any] in UserService.syncUsers()")
                    }
                }
            }
            print("synced users to CoreData, user count = \(User.shared.getAllUsers().count)")
            
        }
        httpService.get(url: "users", completionHandler: completionHandler)
    }
    
    func addUser(id: String, username: String, password: String, name: String, email: String, phone: String) {
        
        var user = [String: Any]()
        user["id"] = id
        user["username"] = username
        user["password"] = password
        user["name"] = name
        user["email"] = email
        user["phone"] = phone
        user["profilePic"] = Util.convertImageToBase64(image: UIImage(named: "default_profile")!)
        
        let completionHandler: (String, [String:Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding user to firebase, error = \(error)")
            } else {
                print("Success in adding user to firebase")
            }
        }
        
        let id = User.shared.getAllUsers().count
        httpService.post(url: "users", data: user, completionHandler: completionHandler)
    }
    
    func addGroupToUser(userId: String, groupId: String) {
        
    }
    
    
}
