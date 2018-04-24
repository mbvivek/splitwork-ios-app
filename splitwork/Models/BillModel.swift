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
    var name: String
    var description: String
    var group: GroupModel
    var amount: Double
    var addedBy: UserModel
    var addedTo: [UserModel]
    
    init(id: Int, name: String, description: String, group: GroupModel, amount: Double, addedBy: UserModel, addedTo: [UserModel]) {
        self.id = id
        self.name = name
        self.description = description
        self.group = group
        self.amount = amount
        self.addedBy = addedBy
        self.addedTo = addedTo
    }
}
