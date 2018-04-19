//
//  TaskModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class TaskModel {
    
    var id: Int
    var group: GroupModel
    var name: String
    var description: String
    var assignedTo: UserModel
    var assignedDate: Date
    var deadlineDate: Date
    var completionDate: Date
    var status: String
    
    init(id: Int, group: GroupModel, name: String, description: String, assignedTo: UserModel, assignedDate: Date, deadlineDate: Date, completionDate: Date, status: String) {
        self.id = id
        self.group = group
        self.name = name
        self.description = description
        self.assignedTo = assignedTo
        self.assignedDate = assignedDate
        self.deadlineDate = deadlineDate
        self.completionDate = completionDate
        self.status = status
    }
}
