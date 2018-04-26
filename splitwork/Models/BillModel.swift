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
    var addedBy: UserModel?
    var addedTo: [UserModel]?
    var amount: Double
    var date: Date?
    var group: GroupModel?
    
    init(id: String, name: String, desc: String, addedBy: UserModel, addedTo: [UserModel], amount: Double, date: Date, group: GroupModel) {
        self.id = id
        self.name = name
        self.desc = desc
        self.addedBy = addedBy
        self.addedTo = addedTo
        self.amount = amount
        self.date = date
        self.group = group
    }
    
}

class Bills {
    
    var bills = [BillModel]()
    
    func addBill(id: String, name: String, desc: String, addedByUsername: String, addedToUsernames: [String], amount: Double, date: Date, groupId: String) {
        if let group = Business.shared().groups?.getGroup(id: groupId) {
            if let addedBy = Business.shared().users?.getUser(username: addedByUsername) {
                var addedTo = [UserModel]()
                for addedToUsername in addedToUsernames {
                    if let addedToUser = Business.shared().users?.getUser(username: addedToUsername) {
                        addedTo.append(addedToUser)
                    }
                }
                let bill = BillModel(id: id, name: name, desc: desc, addedBy: addedBy, addedTo: addedTo, amount: amount, date: date, group: group)
                bills.append(bill)
            }
        }
    }
    
    func getBill(id: String) -> BillModel? {
        for bill in bills {
            if(bill.id == id) {
                return bill
            }
        }
        return nil
    }
}
