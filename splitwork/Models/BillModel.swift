//
//  BillModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class BillModel {
    
    var id: Int
    var task: TaskModel
    var name: String
    var description: String
    var amount: Double
    var addedBy: UserModel
    var addedTo: [UserModel]
    
    init(id: Int, task: TaskModel, name: String, description: String, amount: Double, addedBy: UserModel, addedTo: [UserModel]) {
        self.id = id
        self.task = task
        self.name = name
        self.description = description
        self.amount = amount
        self.addedBy = addedBy
        self.addedTo = addedTo
    }
}
