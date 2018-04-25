//
//  UserAccountService.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class UserAccountService {
    
    let httpService: HTTPService
    
    private static var sharedUserAccountService: UserAccountService = {
        let userAccountService = UserAccountService()
        return userAccountService
    }()
    
    private init() {
        self.httpService = HTTPService.shared()
        print("UserAccountService initialized..")
    }
    
    class func shared() -> UserAccountService {
        return sharedUserAccountService
    }
    
    func getAllUserAccounts() {
        var userAccounts = [String: Any]()
        let completionHandler: (String, [String: Any]) -> () = {error, data in
            if(error != "") {
                print("Error in UserAccountService, getAllUserAccounts")
            } else {
                userAccounts = data
                print("userAccounts = \(userAccounts)")
            }
        }
        httpService.get(url: "useraccounts", completionHandler: completionHandler)
    }
    
    func addUserAccount(userAccount: User) {
        var data = [String: Any]()
        data["username"] = userAccount.username
        data["password"] = userAccount.password
        data["groups"] = userAccount.groups
        
        let completionHandler: (String, [String: Any]) -> () = {error, data in
            if(error != "") {
                print("Error in UserAccountService, getAllUserAccounts")
            } else {
                print("data = \(data)")
            }
        }
        httpService.put(url: "useraccounts", data: data, completionHandler: completionHandler)
    }
}
