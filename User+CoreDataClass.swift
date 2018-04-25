//
//  User+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class User: NSManagedObject {
    
    static let shared = User()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllUsers() -> [User] {
        var users = [User]()
        do {
            users = try context.fetch(User.fetchRequest())
        } catch {
            print("Error fetching users from CoreData")
        }
        return users
    }
    
    func getUser(username: String) -> User? {
        for user in getAllUsers() {
            if(user.username == username) {
                return user
            }
        }
        return nil
    }
    
    func addUser(id: String, username: String, password: String, name: String, email: String, phone: String, profilePic: UIImage, groups: [Group], creditCard: CreditCard) {
        let user = User(context: context)
        user.id = id
        user.username = username
        user.password = String(password.hashValue)
        user.name = name
        user.email = email
        user.phone = phone
        user.profilePic = profilePic
        user.groups = groups
        user.creditCard = creditCard
        appDelegate.saveContext()
    }
    
    func clear() {
        for user in getAllUsers() {
            context.delete(user)
        }
        appDelegate.saveContext()
    }
    
}
