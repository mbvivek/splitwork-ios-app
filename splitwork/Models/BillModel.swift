//
//  BillModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class BillModel {
    
    var id: String?
    var name: String?
    var desc: String?
    var addedBy: String?
    var addedTo: [String]?
    var amount: Double
    var date: Date?
    var groupId: String?
    
    init(id: String, name: String, desc: String, addedBy: String, addedTo: [String], amount: Double, date: Date, groupId: String) {
        self.id = id
        self.name = name
        self.desc = desc
        self.addedBy = addedBy
        self.addedTo = addedTo
        self.amount = amount
        self.date = date
        self.groupId = groupId
    }
    
}

class Bills {
    
    var bills = [BillModel]()
    
    func addBill(id: String, name: String, desc: String, addedBy: String, addedTo: [String], amount: Double, date: Date, groupId: String) {
        let bill = BillModel(id: id, name: name, desc: desc, addedBy: addedBy, addedTo: addedTo, amount: amount, date: date, groupId: groupId)
        bills.append(bill)
    }
    
    func getBill(id: String) -> BillModel? {
        for bill in bills {
            if(bill.id == id) {
                return bill
            }
        }
        return nil
    }
    
    func clear() {
        bills = [BillModel]()
        print("bills cleared, bill count = \(bills.count)")
    }
}
