//
//  Bill+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//
//
//  Bill+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

//
//  Bill+CoreDataClass.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Bill: NSManagedObject {
    
    static let shared = Bill()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllBills() -> [Bill] {
        var bills = [Bill]()
        do {
            bills = try context.fetch(Bill.fetchRequest())
        } catch {
            print("Error fetching bills from CoreData")
        }
        return bills
    }
    
    func getBill(id: String) -> Bill? {
        for bill in getAllBills() {
            if(bill.id == id) {
                return bill
            }
        }
        return nil
    }
    
    func addBill(id: String, name: String, desc: String, addedByUsername: String, addedToUsernames: [String], amount: Double, groupId: String, date: Date) {
        
        let bill = Bill(context: context)
        
        bill.id = id
        bill.name = name
        bill.desc = desc
        
        guard let addedBy = User.shared.getUser(username: addedByUsername) else {
            print("Error fetching user with username = \(addedByUsername) while adding bill in CoreData")
            return
        }
        bill.addedBy = addedBy
        
        var addedTo = [User]()
        for addedToUsername in addedToUsernames {
            if let addedToUser = User.shared.getUser(username: addedToUsername) {
                addedTo.append(addedToUser)
            } else {
                print("Error fetching user with username = \(addedToUsername) while adding bill in CoreData")
            }
        }
        bill.addedTo = addedTo
        
        bill.amount = amount
        
        if let group = Group.shared.getGroup(id: groupId) {
            bill.group = group
        } else {
            print("Error fetching group with id = \(groupId) while adding a bill in CoreData")
        }
        
        
        bill.date = date as NSDate
        
        appDelegate.saveContext()
    }
    
    func editBill(id: String, name: String, desc: String, addedByUsername: String, addedToUsernames: [String], amount: Double, groupId: String, date: Date) {
        
        guard let bill = getBill(id: id) else {
            print("Error fetching bill with id = \(id) to edit in CoreData")
            return
        }
        
        bill.name = name
        bill.desc = desc
        
        guard let addedBy = User.shared.getUser(username: addedByUsername) else {
            print("Error fetching user with username = \(addedByUsername) while adding bill in CoreData")
            return
        }
        bill.addedBy = addedBy
        
        var addedTo = [User]()
        for addedToUsername in addedToUsernames {
            guard let addedToUser = User.shared.getUser(username: addedToUsername) else {
                print("Error fetching user with username = \(addedToUsername) while adding bill in CoreData")
                return
            }
            addedTo.append(addedToUser)
        }
        bill.addedTo = addedTo
        
        bill.amount = amount
        
        guard let group = Group.shared.getGroup(id: groupId) else {
            print("Error fetching group with id = \(groupId) while adding a bill in CoreData")
            return
        }
        bill.group = group
        
        bill.date = date as NSDate
        
        appDelegate.saveContext()
        
    }
    
    func clear() {
        for bill in getAllBills() {
            context.delete(bill)
        }
        appDelegate.saveContext()
    }
    
}

