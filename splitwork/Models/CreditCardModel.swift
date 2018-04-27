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
    
    init(id: String, number: String, nameOnCard: String, expiryMonth: String, expiryYear: String, cvv: String, type: String) {
        self.id = id
        self.number = number
        self.nameOnCard = nameOnCard
        self.expiryMonth = expiryMonth
        self.expiryYear = expiryYear
        self.cvv = cvv
        self.type = type
    }
}

class CreditCards {
    
    var cards = [CreditCardModel]()
    
    func addCreditCard(id: String,number: String, nameOnCard: String, expiryMonth: String, expiryYear: String, cvv: String, type: String) {
        let card = CreditCardModel(id: id,number: number, nameOnCard: nameOnCard, expiryMonth: expiryMonth, expiryYear: expiryYear, cvv: cvv, type: type)
        cards.append(card)
    }
    
    func getCreditCard(id: String) -> CreditCardModel? {
        
        for card in cards {
            if(card.id == id) {
                return card
            }
        }
        return nil
    }
    
    func clear() {
        cards = [CreditCardModel]()
        print("creditCards cleared, creditCard count = \(cards.count)")
    }
    
}
