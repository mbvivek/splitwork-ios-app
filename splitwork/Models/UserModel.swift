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
        
        var id: String?
        var number: String?
        var nameOnCard: String?
        var expiryMonth: String?
        var expiryYear: String?
        var cvv: String?
        var type: String?
        var zip: String?
        
        init(id: String, number: String, nameOnCard: String, expiryMonth: String, expiryYear: String, cvv: String, zip: String, type: String) {
            self.id = id
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

}

class Users {
    
    var users = [UserModel]()
    
    
    
}
