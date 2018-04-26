//
//  Group+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Group: NSManagedObject {
    
    static let shared = Group()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllGroups() -> [Group] {
        var groups = [Group]()
        do {
            groups = try context.fetch(Group.fetchRequest())
        } catch {
            print("Error fetching groups from CoreData")
        }
        return groups
    }
    
    func getGroup(id: String) -> Group? {
        for group in getAllGroups() {
            if(group.id == id) {
                return group
            }
        }
        return nil
    }
    
    func addGroup(id: String, name: String, desc: String, adminUsername: String, memberUsernames: [String], taskIds: [String], billIds: [String]) {
        let group = Group(context: context)
        group.id = id
        group.name = name
        group.desc = desc
        
        guard let admin = User.shared.getUser(username: adminUsername) else {
            print("Error fetching user with username = \(adminUsername) from CoreData")
            return
        }
        group.admin = admin
        
        var members = [User]()
        for memberUsername in memberUsernames {
            if let member = User.shared.getUser(username: memberUsername) {
                members.append(member)
            } else {
                print("Error fetching user with username = \(adminUsername) from CoreData")
            }
        }
        group.members = members
        
        var tasks = [Task]()
        for taskId in taskIds {
            if let task = Task.shared.getTask(id: taskId) {
                tasks.append(task)
            } else {
                print("Error fetching task with id = \(taskId) while adding group in CoreData")
            }
        }
        group.tasks = tasks
        
        var bills = [Bill]()
        for billId in billIds {
            if let bill = Bill.shared.getBill(id: billId) {
                bills.append(bill)
            } else {
                print("Error fetching bill with id = \(billId) while adding group in CoreData")
            }
        }
        group.bills = bills
        
        appDelegate.saveContext()
    }
    
    func deleteGroup(id: String) {
        if let group = getGroup(id: id) {
            context.delete(group)
            appDelegate.saveContext()
        } else {
            print("Cannot find group with id = \(id) to delete from CoreData")
        }
    }
    
    func clear() {
        for group in getAllGroups(){
            context.delete(group)
        }
        appDelegate.saveContext()
    }
    
}
