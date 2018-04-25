//
//  CreditCard+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension CreditCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CreditCard> {
        return NSFetchRequest<CreditCard>(entityName: "CreditCard")
    }

    @NSManaged public var cvv: String?
    @NSManaged public var expiryMonth: String?
    @NSManaged public var expiryYear: String?
    @NSManaged public var id: String?
    @NSManaged public var nameOnCard: String?
    @NSManaged public var number: String?
    @NSManaged public var type: String?
    @NSManaged public var zip: String?

}
