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
                        let id = _user.key
                        let username = user["username"] as! String
                        let password = user["password"] as! String
                        let name = user["name"] as! String
                        let email = user["email"] as! String
                        let phone = user["phone"] as! String
                        let profilePic = Util.convertBase64ToImage(base64String: user["profilePic"] as! String)
                        var groupIds = [String]()
                        if let _groupIds = user["groupIds"] as? [String: Any] {
                            for _groupId in _groupIds {
                                if let __groupId = _groupId.value as? [String: Any] {
                                    groupIds.append(__groupId["groupId"] as! String)
                                }
                            }
                        } else {
                            print("Error parsing groups to [String] in UserService.syncUsers()")
                        }
                        var creditCardId = ""
                        if let _creditCardId = user["cardId"] as? String {
                            creditCardId = _creditCardId
                        }

                        // add user to model
                        Business.shared().users?.addUser(id: id, username: username, password: password, name: name, email: email, phone: phone, profilePic: profilePic, groupIds: groupIds, creditCardId: creditCardId)
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
        user["cardId"] = ""
        
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
        var groupToUser = [String: Any]()
        groupToUser["groupId"] = groupId
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding group to user, error = \(error)")
            } else {
                print("Success in adding group to user")
                self.syncUsers(onSync: nil)
            }
        }
        httpService.post(url: "users/\(userId)/groupIds", data: groupToUser, completionHandler: completionHandler)
    }
    
    func addCardToUser(userId: String, cardId: String) {
        
        var cardToUser = [String: Any]()
        cardToUser["cardId"] = cardId
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding card to user, error = \(error)")
            } else {
                print("Success in adding card to user")
                self.syncUsers(onSync: nil)
            }
        }
        httpService.patch(url: "users/\(userId)", data: cardToUser, completionHandler: completionHandler)
    }
    
    func updateUser(userId: String, name: String, email: String, phone: String) {
        
        var user = [String: Any]()
        user["name"] = name
        user["email"] = email
        user["phone"] = phone
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in updating user, error = \(error)")
            } else {
                print("Success updating user")
                self.syncUsers(onSync: nil)
            }
        }
        httpService.patch(url: "users/\(userId)", data: user, completionHandler: completionHandler)
        
    }
    
    func updateProfilePic(userId: String, profilePic: UIImage) {
        var user = [String: Any]()
        user["profilePic"] = Util.convertImageToBase64(image: profilePic)
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in updating profile pic, error = \(error)")
            } else {
                print("Success updating profile pic")
                self.syncUsers(onSync: nil)
            }
        }
        httpService.patch(url: "users/\(userId)", data: user, completionHandler: completionHandler)
    }
    
    func updatePassword(userId: String, password: String) {
        var user = [String: Any]()
        user["password"] = String(password.hashValue)
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in updating profile pic, error = \(error)")
            } else {
                print("Success updating profile pic")
                self.syncUsers(onSync: nil)
            }
        }
        httpService.patch(url: "users/\(userId)", data: user, completionHandler: completionHandler)
    }
    
    
}

