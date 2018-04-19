//
//  PaymentModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class PaymentModel {
    
    var id: Int
    var date: Date
    var fromUser: UserModel
    var toUser: UserModel
    var fromCreditCard: UserModel.UserPaymentInfo.CreditCard
    var toCreditCard: UserModel.UserPaymentInfo.CreditCard
    var amount: Double
    var status: String
    
    init(id: Int, date: Date, fromUser: UserModel, toUser: UserModel, fromCreditCard: UserModel.UserPaymentInfo.CreditCard, toCreditCard: UserModel.UserPaymentInfo.CreditCard, amount: Double, status: String) {
        self.id = id
        self.date = date
        self.fromUser = fromUser
        self.toUser = toUser
        self.fromCreditCard = fromCreditCard
        self.toCreditCard = toCreditCard
        self.amount = amount
        self.status = status
    }
}
