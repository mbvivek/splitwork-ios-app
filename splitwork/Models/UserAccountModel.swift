//
//  UserAccountModel.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class UserAccount {
    
    var username: String
    var password: String
    var isActive: Bool
    var groups: [GroupModel]
    
    init(username: String, password: String, isActive: Bool, groups: [GroupModel]) {
        self.username = username
        self.password = password
        self.isActive = isActive
        self.groups = groups
    }
    
}


