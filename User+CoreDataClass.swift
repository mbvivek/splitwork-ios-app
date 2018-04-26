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
    
    func addUser(id: String, username: String, password: String, name: String, email: String, phone: String, profilePic: UIImage, groupIds: [String]) {
        let user = User(context: context)
        user.id = id
        user.username = username
        user.password = String(password.hashValue)
        user.name = name
        user.email = email
        user.phone = phone
        user.profilePic = profilePic
        var groups = [Group]()
        for groupId in groupIds {
            if let group = Group.shared.getGroup(id: groupId) {
                groups.append(group)
            }
        }
        user.groups = groups
        user.creditCard = nil
        appDelegate.saveContext()
    }
    
    func addCreditCardToUser(username: String, id: String, number: String, nameOnCard: String, expiryMonth: String, expiryYear: String, cvv: String, zip: String, type: String) {
        if let user = getUser(username: username) {
            let creditCard = CreditCard(context: context)
            creditCard.id = "0"
            creditCard.number = number
            creditCard.nameOnCard = nameOnCard
            creditCard.expiryMonth = expiryMonth
            creditCard.expiryYear = expiryYear
            creditCard.cvv = cvv
            creditCard.zip = zip
            creditCard.type = type
            
            user.creditCard = creditCard
            
            appDelegate.saveContext()
        } else {
            print("Error fetching user with username = \(username) while adding creditCardToUser in CoreData")
            return
        }
    }
    
    func clear() {
        for user in getAllUsers() {
            context.delete(user)
        }
        appDelegate.saveContext()
    }
    
}
