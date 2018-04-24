//
//  GroupModel+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension GroupModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupModel> {
        return NSFetchRequest<GroupModel>(entityName: "GroupModel")
    }

    @NSManaged public var bills: NSObject?
    @NSManaged public var desc: String?
    @NSManaged public var id: Int32
    @NSManaged public var members: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var tasks: NSObject?
    @NSManaged public var admin: UserAccountModel?

}
