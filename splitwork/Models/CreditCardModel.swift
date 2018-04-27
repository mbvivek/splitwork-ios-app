//
//  CreditCardModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/26/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

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
        self.number = number
        self.nameOnCard = nameOnCard
        self.expiryMonth = expiryMonth
        self.expiryYear = expiryYear
        self.cvv = cvv
        self.zip = zip
        self.type = type
    }
}

class CreditCards {
    
    var creditCards = [CreditCardModel]()
    
    func addCreditCard(id: String,number: String, nameOnCard: String, expiryMonth: String, expiryYear: String, cvv: String, zip: String, type: String) {
        let creditcard = CreditCardModel(id: id,number: number, nameOnCard: nameOnCard, expiryMonth: expiryMonth, expiryYear: expiryYear, cvv: cvv, zip: zip, type: type)
        creditCards.append(creditcard)
    }
    
    func getCreditCard(id: String) -> CreditCardModel? {
        for creditCard in creditCards {
            if(creditCard.id == id) {
                return creditCard
            }
        }
        return nil
    }
    
    func clear() {
        creditCards = [CreditCardModel]()
        print("creditCards cleared, creditCard count = \(creditCards.count)")
    }
    
}
