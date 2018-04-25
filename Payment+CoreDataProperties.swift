//
//  Payment+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: NSDate?
    @NSManaged public var id: String?
    @NSManaged public var status: String?
    @NSManaged public var fromCreditCard: CreditCard?
    @NSManaged public var fromUser: User?
    @NSManaged public var toCreditCard: CreditCard?
    @NSManaged public var toUser: User?

}
