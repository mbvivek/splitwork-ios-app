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
    
    init(id: String, fromUser:String, toUser:String, amount:Double, date:Date) {
        self.id = id
        self.fromUser = fromUser
        self.toUser = toUser
        self.amount = amount
        self.date = date
    }
    
}

class Payments {
    
    var payments = [PaymentModel]()
    
}
