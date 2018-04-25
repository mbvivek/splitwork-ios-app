//
//  Bill+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension Bill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bill> {
        return NSFetchRequest<Bill>(entityName: "Bill")
    }

    @NSManaged public var addedTo: NSObject?
    @NSManaged public var amount: Double
    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var addedBy: User?
    @NSManaged public var group: Group?

}
