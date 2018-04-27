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
    var fromUser: String?
    var toUser: String?
    var amount: Double
    var date: Date?
    
    init(id: String, fromUser: String, toUser: String, amount: Double, date: Date) {
        self.id = id
        self.fromUser = fromUser
        self.toUser = toUser
        self.amount = amount
        self.date = date
    }
    
}

class Payments {
    
    var payments = [PaymentModel]()
    
    func addPayment(id: String, fromUser:String, toUser:String, amount:Double, date:Date) {
        let payment = PaymentModel(id: id, fromUser: fromUser, toUser: toUser, amount: amount, date: date)
        payments.append(payment)
    }
    
    func getPayment(id: String) -> PaymentModel? {
        for payment in payments {
            if(payment.id == id) {
                return payment
            }
        }
        return nil
    }
    
    func clear() {
        payments = [PaymentModel]()
        print("payments cleared, payment count = \(payments.count)")
    }
    
}
