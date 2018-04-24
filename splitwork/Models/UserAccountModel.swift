//
//  UserAccountModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class UserAccountModel {
    
    var id: Int
    var username: String
    var password: String
    var isActive: Bool
    var groups: [GroupModel]
    
    init(username: String, password: String, isActive: Bool, groups: [GroupModel]) {
        self.id = Date().hashValue
        self.username = username
        self.password = password
        self.isActive = isActive
        self.groups = groups
    }
    
    init(id: Int, username: String, password: String, isActive: Bool, groups: [GroupModel]) {
        self.id = id
        self.username = username
        self.password = password
        self.isActive = isActive
        self.groups = groups
    }
}


