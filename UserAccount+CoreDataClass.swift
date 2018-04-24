//
//  UserAccount+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class UserAccount: NSManagedObject {
    
    static let shared = UserAccount()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addUserAccount(username: String, password: String) -> Bool {
        // if this username already exists, return
        if getUserAccount(username: username) != nil {
            return false
        }
        let userAccount = UserAccount(context: context)
        userAccount.username = username
        userAccount.password = Int32(password.hashValue)
        userAccount.isActive = true
        userAccount.groups = [Group]() as NSObject
        return true
    }
    
    func getUserAccount(username: String) -> UserAccount? {
        for userAccount in getAllUserAccounts() {
            if(userAccount.username == username) {
                return userAccount
            }
        }
        return nil
    }
    
    func getAllUserAccounts() -> [UserAccount] {
        var userAccounts = [UserAccount]()
        do {
            userAccounts = try context.fetch(UserAccount.fetchRequest())
        } catch {
            print("Error fetching data from CoreData in getAllUserAccounts")
        }
        return userAccounts
    }

}
