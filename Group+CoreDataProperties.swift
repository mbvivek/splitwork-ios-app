//
//  Group+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var bills: NSObject?
    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var members: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var tasks: NSObject?
    @NSManaged public var admin: User?

}