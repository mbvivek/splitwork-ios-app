//
//  UserModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class UserModel {
    
    class UserPersonalInfo {
        
        var name: String
        var profilePic: Data
        
        init(name: String, profilePic: Data) {
            self.name = name
            self.profilePic = profilePic
        }
    }
    
    class UserContactInfo {
        
        var email: String
        var phone: String
        
        init(email: String, phone: String) {
            self.email = email
            self.phone = phone
        }
    }
    
    class UserPaymentInfo {
        
        class CreditCard {
            
            var id: String
            var number: String
            var nameOnCard: String
            var cvv: String
            var expiryMonth: String
            var expiryYear: String
            var zip: String
            
            init(id: String, number:String, nameOnCard: String, cvv: String, expiryMonth: String, expiryYear: String, zip: String) {
                self.id = id
                self.number = number
                self.nameOnCard = nameOnCard
                self.cvv = cvv
                self.expiryMonth = expiryMonth
                self.expiryYear = expiryYear
                self.zip = zip
            }
        }
        
        var creditCards = [CreditCard]()
        
        init(creditCards: [CreditCard]) {
            self.creditCards = creditCards
        }
    }
    
    var personalInfo: UserPersonalInfo
    var contactInfo: UserContactInfo
    var paymentInfo: UserPaymentInfo
    
    init(personalInfo: UserPersonalInfo, contactInfo: UserContactInfo, paymentInfo: UserPaymentInfo) {
        self.personalInfo = personalInfo
        self.contactInfo = contactInfo
        self.paymentInfo = paymentInfo
    }
}
