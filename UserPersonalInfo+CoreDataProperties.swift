//
//  UserPersonalInfo+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension UserPersonalInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPersonalInfo> {
        return NSFetchRequest<UserPersonalInfo>(entityName: "UserPersonalInfo")
    }

    @NSManaged public var name: String?
    @NSManaged public var profilePic: NSObject?

}
