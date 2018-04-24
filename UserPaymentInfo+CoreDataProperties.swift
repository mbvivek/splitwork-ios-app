//
//  UserPaymentInfo+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension UserPaymentInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPaymentInfo> {
        return NSFetchRequest<UserPaymentInfo>(entityName: "UserPaymentInfo")
    }

    @NSManaged public var cvv: String?
    @NSManaged public var expiryMonth: String?
    @NSManaged public var expiryYear: String?
    @NSManaged public var id: Int32
    @NSManaged public var nameOnCard: String?
    @NSManaged public var number: String?
    @NSManaged public var zip: String?

}
