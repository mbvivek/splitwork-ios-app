//
//  UserModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class UserModel {

    var id: String?
    var username: String?
    var password: String?
    var name: String?
    var email: String?
    var phone: String?
    var profilePic: UIImage?
    var groupIds: [String]?
    var creditCardId: String?
    
    init(id: String, username: String, password: String, name: String, email: String, phone: String, profilePic: UIImage, groupIds: [String], creditCardId: String) {
        self.id = id
        self.username = username
        self.password = password
        self.name = name
        self.email = email
        self.phone = phone
        self.profilePic = profilePic
        self.groupIds = groupIds
        self.creditCardId = creditCardId
    }

}

class Users {
    
    var users = [UserModel]()
    
    func getUser(username: String) -> UserModel? {
        for user in users {
            if(user.username == username) {
                return user
            }
        }
        return nil
    }
    
    func getUser(id: String) -> UserModel? {
        for user in users {
            if(user.id == id) {
                return user
            }
        }
        return nil
    }
    
    func addUser(id: String,username: String, password: String, name: String, email: String, phone: String, profilePic: UIImage, groupIds: [String], creditCardId: String) {
        let user = UserModel(id: id, username: username, password: password, name: name, email: email, phone: phone, profilePic: profilePic, groupIds: groupIds, creditCardId: creditCardId)
        users.append(user)
    }
    
    func clear() {
        users = [UserModel]()
        print("users cleared, user count = \(users.count)")
    }
    
}
