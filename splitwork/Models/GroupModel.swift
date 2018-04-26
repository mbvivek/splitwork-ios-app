//
//  GroupModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class GroupModel {
    
    var id: String?
    var name: String?
    var desc: String?
    var admin: User?
    var members: [UserModel]?
    var tasks: [TaskModel]?
    var bills: [BillModel]?
    
    init(id: String, name: String, desc: String, adminUsername: String, memberUsernames: [String], taskIds: [String], billIds: [String]) {
        self.id = id
        self.name = name
        self.desc = desc
        
        guard let admin = User.shared.getUser(username: adminUsername) else {
            print("Error fetching user with username = \(adminUsername) from CoreData")
            return
        }
        self.admin = admin
        
        var members = [User]()
        for memberUsername in memberUsernames {
            if let member = User.shared.getUser(username: memberUsername) {
                members.append(member)
            } else {
                print("Error fetching user with username = \(adminUsername) from CoreData")
            }
        }
        self.members = members
        
        var tasks = [Task]()
        for taskId in taskIds {
            if let task = Task.shared.getTask(id: taskId) {
                tasks.append(task)
            } else {
                print("Error fetching task with id = \(taskId) while adding group in CoreData")
            }
        }
        self.tasks = tasks
        
        var bills = [Bill]()
        for billId in billIds {
            if let bill = Bill.shared.getBill(id: billId) {
                bills.append(bill)
            } else {
                print("Error fetching bill with id = \(billId) while adding group in CoreData")
            }
        }
        self.bills = bills
    }
    
}

class Groups {
    
    var groups = [GroupModel]()
    
}
