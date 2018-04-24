//
//  UserContactInfo+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension UserContactInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserContactInfo> {
        return NSFetchRequest<UserContactInfo>(entityName: "UserContactInfo")
    }

    @NSManaged public var email: String?
    @NSManaged public var phone: String?

}
