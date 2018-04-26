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
    var admin: UserModel?
    var members: [UserModel]?
    var tasks: [TaskModel]?
    var bills: [BillModel]?
    
    init(id: String, name: String, desc: String, admin: UserModel, members: [UserModel], tasks: [TaskModel], bills: [BillModel]) {
        self.id = id
        self.name = name
        self.desc = desc
        self.admin = admin
        self.members = members
        self.tasks = tasks
        self.bills = bills
    }
    
}

class Groups {
    
    var groups = [GroupModel]()
    
    func addGroup(id: String, name: String, desc: String, adminUsername: String, memberUsernames: [String], taskIds: [String], billIds: [String]) {
        if let admin = Business.shared().users?.getUser(username: adminUsername) {
            var members = [UserModel]()
            for memberUsername in memberUsernames {
                if let member = Business.shared().users?.getUser(username: memberUsername) {
                    members.append(member)
                }
            }
            var tasks = [TaskModel]()
            for taskId in taskIds {
                if let task = Business.shared().tasks?.getTask(id: taskId) {
                    tasks.append(task)
                }
            }
            var bills = [BillModel]()
            for billId in billIds {
                if let bill = Business.shared().bills?.getBill(id: billId) {
                    bills.append(bill)
                }
            }
            let group = GroupModel(id: id, name: name, desc: desc, admin: admin, members: members, tasks: tasks, bills: bills)
            groups.append(group)
        }
    }
    
    func getGroup(id: String) -> GroupModel? {
        for group in groups {
            if(group.id == id) {
                return group
            }
        }
        return nil
    }
    
    func clear() {
        groups = [GroupModel]()
        print("groups cleared, group count = \(groups.count)")
    }
    
}
