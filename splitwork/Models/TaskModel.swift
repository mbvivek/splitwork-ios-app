//
//  TaskModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class TaskModel {
    
    var id: String?
    var name: String?
    var desc: String?
    var assignedTo: UserModel?
    var assignedDate: Date?
    var deadlineDate: Date?
    var completionDate: Date?
    var group: GroupModel?
    var status: String?
    var completionPercentage: Double?
    
    init(id: String, name: String, desc: String, groupId: String, assignedToUsername: String, assignedDate: Date, deadlineDate: Date, completionDate: Date, status: String, completionPercentage: Double) {
        
        self.id = id
        self.name = name
        self.desc = desc
        if let group = Group.shared.getGroup(id: groupId) {
            self.group = group
        } else {
            print("Error fetching group with id = \(groupId) to add a task in CoreData")
        }
        if let assignedTo = User.shared.getUser(username: assignedToUsername) {
            self.assignedTo = assignedTo
        } else {
            print("Error fetching user with username = \(assignedToUsername) to add a task in CoreData")
        }
        self.assignedDate = assignedDate as NSDate
        self.deadlineDate = deadlineDate as NSDate
        self.completionDate = completionDate as NSDate
        self.status = status
        self.completionPercentage = completionPercentage
        
    }
    
}

class Tasks {
    
    var tasks = [TaskModel]()
}
