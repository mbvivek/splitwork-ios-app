//
//  Task+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var assignedDate: NSDate?
    @NSManaged public var completionDate: NSDate?
    @NSManaged public var deadlineDate: NSDate?
    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var percentageCompleted: Double
    @NSManaged public var status: String?
    @NSManaged public var assignedTo: User?
    @NSManaged public var group: Group?

}
