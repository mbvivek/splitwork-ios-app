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
    var adminUsername: String?
    var memberUsernames: [String]?
    var taskIds: [String]?
    var billIds: [String]?
    
    init(id: String, name: String, desc: String, adminUsername: String, memberUsernames: [String], taskIds: [String], billIds: [String]) {
        self.id = id
        self.name = name
        self.desc = desc
        self.adminUsername = adminUsername
        self.memberUsernames = memberUsernames
        self.taskIds = taskIds
        self.billIds = billIds
    }
}

class Groups {
    
    var groups = [GroupModel]()
    
    func addGroup(id: String, name: String, desc: String, adminUsername: String, memberUsernames: [String], taskIds: [String], billIds: [String]) {
        let group = GroupModel(id: id, name: name, desc: desc, adminUsername: adminUsername, memberUsernames: memberUsernames, taskIds: taskIds, billIds: billIds)
        groups.append(group)
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
