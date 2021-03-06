//
//  LoggedInUser+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension LoggedInUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoggedInUser> {
        return NSFetchRequest<LoggedInUser>(entityName: "LoggedInUser")
    }

    @NSManaged public var username: String?

}
