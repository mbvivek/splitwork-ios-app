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
    
    init(id: String, name: String, desc: String, assignedTo: UserModel, assignedDate: Date, deadlineDate: Date, completionDate: Date, group: GroupModel, status: String, completionPercentage: Double) {
        
        self.id = id
        self.name = name
        self.desc = desc
        self.assignedTo = assignedTo
        self.assignedDate = assignedDate
        self.deadlineDate = deadlineDate
        self.completionDate = completionDate
        self.group = group
        self.status = status
        self.completionPercentage = completionPercentage
        
    }
    
}

class Tasks {
    
    var tasks = [TaskModel]()
    
    func addTask(id: String, name: String, desc: String, assignedToUsername: String, assignedDate: Date, deadlineDate: Date, completionDate: Date, groupId: String, status: String, completionPercentage: Double) {
        if let assignedTo = Business.shared().users?.getUser(username: assignedToUsername) {
            if let group = Business.shared().groups?.getGroup(id: groupId) {
                let task = TaskModel(id: id, name: name, desc: desc, assignedTo: assignedTo, assignedDate: assignedDate, deadlineDate: deadlineDate, completionDate: completionDate, group: group, status: status, completionPercentage: completionPercentage)
                tasks.append(task)
            }
        }
    }
    
    func getTask(id: String) -> TaskModel? {
        for task in tasks {
            if(task.id == id) {
                return task
            }
        }
        return nil
    }
    
    func clear() {
        tasks = [TaskModel]()
        print("tasks cleared, task count = \(tasks.count)")
    }
}
