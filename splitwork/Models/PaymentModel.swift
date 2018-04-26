//
//  PaymentModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class PaymentModel {
    
    var id: String?
    var fromUser: UserModel?
    var toUser: UserModel?
    var amount: Double
    var date: Date?
    
    init(id: String, fromUser: UserModel, toUser: UserModel, amount: Double, date: Date) {
        self.id = id
        self.fromUser = fromUser
        self.toUser = toUser
        self.amount = amount
        self.date = date
    }
    
}

class Payments {
    
    var payments = [PaymentModel]()
    
    func addPayment(id: String, fromUserUsername:String, toUserUsername:String, amount:Double, date:Date) {
        if let fromUser = Business.shared().users?.getUser(username: fromUserUsername) {
            if let toUser = Business.shared().users?.getUser(username: toUserUsername) {
                let payment = PaymentModel(id: id, fromUser: fromUser, toUser: toUser, amount: amount, date: date)
                payments.append(payment)
            }
        }
    }
    
    func getPayment(id: String) -> PaymentModel? {
        for payment in payments {
            if(payment.id == id) {
                return payment
            }
        }
        return nil
    }
    
}
