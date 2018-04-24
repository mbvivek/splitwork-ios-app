//
//  Bill+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
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
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var addedBy: UserAccount?
    @NSManaged public var group: Group?

}
