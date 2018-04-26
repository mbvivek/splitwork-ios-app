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
    
    class CreditCardModel {
        
        var number: String?
        var nameOnCard: String?
        var expiryMonth: String?
        var expiryYear: String?
        var cvv: String?
        var type: String?
        var zip: String?
        
        init(number: String, nameOnCard: String, expiryMonth: String, expiryYear: String, cvv: String, zip: String, type: String) {
            self.number = number
            self.nameOnCard = nameOnCard
            self.expiryMonth = expiryMonth
            self.expiryYear = expiryYear
            self.cvv = cvv
            self.zip = zip
            self.type = type
        }
    }
    
    var id: String?
    var username: String?
    var password: String?
    var name: String?
    var email: String?
    var phone: String?
    var profilePic: UIImage?
    var groups: [GroupModel]?
    var creditCard: CreditCardModel?
    
    init(id: String, username: String, password: String, name: String, email: String, phone: String, profilePic: UIImage, groups: [GroupModel], creditCard: CreditCardModel!) {
        self.id = id
        self.username = username
        self.password = password
        self.name = name
        self.email = email
        self.phone = phone
        self.profilePic = profilePic
        self.groups = groups
        self.creditCard = creditCard
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
    
    func addUser(id: String, username: String, password: String, name: String, email: String, phone: String, profilePic: UIImage, groupIds: [String]) {
        var groups = [GroupModel]()
        for groupId in groupIds {
            if let group = Business.shared().groups?.getGroup(id: groupId) {
                groups.append(group)
            }
        }
        let user = UserModel(id: id, username: username, password: password, name: name, email: email, phone: phone, profilePic: profilePic, groups: groups, creditCard: nil)
        users.append(user)
    }
    
    func addCreditCard(username: String, number: String, nameOnCard: String, expiryMonth: String, expiryYear: String, cvv: String, zip: String, type: String) {
        if let user = getUser(username: username) {
            let creditCard = UserModel.CreditCardModel(number: number, nameOnCard: nameOnCard, expiryMonth: expiryMonth, expiryYear: expiryYear, cvv: cvv, zip: zip, type: type)
            user.creditCard = creditCard
        }
    }
    
}
