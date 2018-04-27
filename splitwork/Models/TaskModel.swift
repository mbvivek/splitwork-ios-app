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
    var assignedTo: String?
    var assignedDate: Date?
    var deadlineDate: Date?
    var completionDate: Date?
    var groupId: String?
    var status: String?
    var completionPercentage: Double?
    
    init(id: String, name: String, desc: String, assignedTo: String, assignedDate: Date, deadlineDate: Date, completionDate: Date, groupId: String, status: String, completionPercentage: Double) {
        
        self.id = id
        self.name = name
        self.desc = desc
        self.assignedTo = assignedTo
        self.assignedDate = assignedDate
        self.deadlineDate = deadlineDate
        self.completionDate = completionDate
        self.groupId = groupId
        self.status = status
        self.completionPercentage = completionPercentage
        
    }
    
}

class Tasks {
    
    var tasks = [TaskModel]()
    
    func addTask(id: String, name: String, desc: String, assignedTo: String, assignedDate: Date, deadlineDate: Date, completionDate: Date, groupId: String, status: String, completionPercentage: Double) {
        let task = TaskModel(id: id, name: name, desc: desc, assignedTo: assignedTo, assignedDate: assignedDate, deadlineDate: deadlineDate, completionDate: completionDate, groupId: groupId, status: status, completionPercentage: completionPercentage)
        tasks.append(task)
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
