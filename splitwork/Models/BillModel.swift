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
    var addedBy: User?
    var addedTo: [User]?
    var amount: Double
    var date: NSDate?
    var group: Group?
    
    init(id: String, name: String, desc: String, addedByUsername: String, addedToUsernames: [String], amount: Double, groupId: String, date: Date) {
        
        self.id = id
        self.name = name
        self.desc = desc
        
        if let addedBy = User.shared.getUser(username: addedByUsername) {
            self.addedBy = addedBy
        }
        else {
            print("Error fetching user with username = \(addedByUsername) while adding bill in CoreData")
        }
        
        var addedTo = [User]()
        for addedToUsername in addedToUsernames {
            if let addedToUser = User.shared.getUser(username: addedToUsername) {
                addedTo.append(addedToUser)
            } else {
                print("Error fetching user with username = \(addedToUsername) while adding bill in CoreData")
            }
        }
        self.addedTo = addedTo
        
        self.amount = amount
        
        if let group = Group.shared.getGroup(id: groupId) {
            self.group = group
        } else {
            print("Error fetching group with id = \(groupId) while adding a bill in CoreData")
        }

        self.date = date as NSDate
        
    }
    
}

class Bills {
    
    var bills = [Bill]()
}
