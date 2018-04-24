//
//  UserAccount+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension UserAccount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAccount> {
        return NSFetchRequest<UserAccount>(entityName: "UserAccount")
    }

    @NSManaged public var groups: NSObject?
    @NSManaged public var id: Int32
    @NSManaged public var isActive: Bool
    @NSManaged public var password: Int32
    @NSManaged public var username: String?
    @NSManaged public var user: User?

}
