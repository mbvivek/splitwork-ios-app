//
//  GroupModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class GroupModel {
    
    var id: Int
    var name: String
    var description: String
    var createdBy: UserModel
    var admin: UserModel
    var members = [UserModel]()
    var tasks = [TaskModel]()
    var bills = [BillModel]()
    
    init(name: String, description: String, createdBy: UserModel, admin: UserModel, members: [UserModel], tasks: [TaskModel], bills: [BillModel]) {
        self.id = Date().hashValue
        self.name = name
        self.description = description
        self.createdBy = createdBy
        self.admin = admin
        self.members = members
        self.tasks = tasks
    }
    
    init(id: Int, name: String, description: String, createdBy: UserModel, admin: UserModel, members: [UserModel], tasks: [TaskModel], bills: [BillModel]) {
        self.id = id
        self.name = name
        self.description = description
        self.createdBy = createdBy
        self.admin = admin
        self.members = members
        self.tasks = tasks
    }
}
