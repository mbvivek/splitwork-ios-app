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
    
    func syncUsers(onSync: (() -> ())?) {
        Business.shared().users?.clear()
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in UserService.syncUsers()")
            } else {
                if let users = data["data"] as? [String:Any] {
                    print("received users from server, user count \(users.count)")
                    for _user in users {
                        
                        let user = _user.value as! [String: Any]
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
                        // add user to model
                        Business.shared().users?.addUser(username: username, password: password, name: name, email: email, phone: phone, profilePic: profilePic, groupIds: groupIds)
                        
                        // check if credit card details are available
                        if let _creditCard = user["creditCard"] as? [String: Any] {
                            let ccNumber = _creditCard["number"] as! String
                            let ccNameOnCard = _creditCard["nameOnCard"] as! String
                            let ccExpiryMonth = _creditCard["expiryMonth"] as! String
                            let ccExpiryYear = _creditCard["expiryYear"] as! String
                            let ccCvv = _creditCard["cvv"] as! String
                            let ccZip = _creditCard["zip"] as! String
                            let ccType = _creditCard["type"] as! String
                            // add credit card to user model
                            Business.shared().users?.addCreditCard(username: username, number: ccNumber, nameOnCard: ccNameOnCard, expiryMonth: ccExpiryMonth, expiryYear: ccExpiryYear, cvv: ccCvv, zip: ccZip, type: ccType)
                        } else {
                            print("Error parsing creditCard to [String:Any] in UserService.syncUsers()")
                        }
                    }
                }
            }
            print("synced users from server, user count = \((Business.shared().users?.users.count)!)")
            onSync?()
        }
        httpService.get(url: "users", completionHandler: completionHandler)
    }
    
    func addUser(username: String, password: String, name: String, email: String, phone: String) {
        
        var user = [String: Any]()
        user["username"] = username
        user["password"] = String(password.hashValue)
        user["name"] = name
        user["email"] = email
        user["phone"] = phone
        user["profilePic"] = Util.convertImageToBase64(image: UIImage(named: "default_profile")!)
        
        let completionHandler: (String, [String:Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding user to firebase, error = \(error)")
            } else {
                print("Success in adding user to firebase")
                self.syncUsers(onSync: nil)
            }
        }
        httpService.post(url: "users", data: user, completionHandler: completionHandler)
    }
    
    func addGroupToUser(userId: String, groupId: String) {
        
    }
    
    
}

