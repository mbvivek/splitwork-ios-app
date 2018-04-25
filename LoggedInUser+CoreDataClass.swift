//
//  LoggedInUser+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class LoggedInUser: NSManagedObject {
    
    static let shared = LoggedInUser()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllUsers() -> [LoggedInUser] {
        var users = [LoggedInUser]()
        do {
            users = try context.fetch(LoggedInUser.fetchRequest())
        } catch {
            print("Error fetching logged in users from CoreData")
        }
        return users
    }
    
    func getUser(username: String) -> LoggedInUser? {
        if getAllUsers().count == 0 {
            return nil
        }
        return getAllUsers()[0]
    }
    
    func addUser(username: String) {
        let user = LoggedInUser(context: context)
        user.username = username
        appDelegate.saveContext()
    }
    
    func clear() {
        for user in getAllUsers() {
            context.delete(user)
        }
        appDelegate.saveContext()
    }
    
}
