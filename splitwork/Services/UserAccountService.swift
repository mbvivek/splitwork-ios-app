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
    
    func getUserAccount(username: String) {
        
        var userAccount = [String: Any]()
        let completionHandler: (String, [String: Any]) -> ([String: Any]) = {error, data in
            if(error != "") {
                print("Error: getUserAccount(\(username) \n \(error)")
            } else {
                userAccount = data
            }
            return userAccount
        }
        
    }
}
