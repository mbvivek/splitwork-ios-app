//
//  User+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var username: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var groups: NSObject?
    @NSManaged public var profilePic: NSObject?
    @NSManaged public var creditCard: UserPaymentInfo?

}
