//
//  Task+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Task: NSManagedObject {
    
    static let shared = Task()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllTasks() -> [Task] {
        var tasks = [Task]()
        do {
            tasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("Error fetching tasks from CoreData")
        }
        return tasks
    }
    
    func getTask(id: String) -> Task? {
        for task in getAllTasks() {
            if(task.id == id) {
                return task
            }
        }
        return nil
    }
    
    func addTask(id: String, name: String, desc: String, groupId: String, assignedToUsername: String, assignedDate: Date, deadlineDate: Date, completionDate: Date, status: String, percentageCompleted: Double) {
        
        let task = Task(context: context)
        task.id = id
        task.name = name
        task.desc = desc
        
        guard let group = Group.shared.getGroup(id: groupId) else {
            print("Error fetching group with id = \(groupId) to add a task in CoreData")
            return
        }
        task.group = group
        
        guard let assignedTo = User.shared.getUser(username: assignedToUsername) else {
            print("Error fetching user with username = \(assignedToUsername) to add a task in CoreData")
            return
        }
        task.assignedTo = assignedTo
        
        task.assignedDate = assignedDate as NSDate
        task.deadlineDate = deadlineDate as NSDate
        task.completionDate = completionDate as NSDate
        task.status = status
        task.percentageCompleted = percentageCompleted
        
        appDelegate.saveContext()
        
    }
    
    func clear() {
        for task in getAllTasks() {
            context.delete(task)
        }
        appDelegate.saveContext()
    }
    
}
