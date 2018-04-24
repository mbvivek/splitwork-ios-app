//
//  PaymentModel+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension PaymentModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PaymentModel> {
        return NSFetchRequest<PaymentModel>(entityName: "PaymentModel")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var status: String?
    @NSManaged public var fromCreditCard: UserPaymentInfoModel?
    @NSManaged public var fromUser: UserAccountModel?
    @NSManaged public var toCreditCard: UserPaymentInfoModel?
    @NSManaged public var toUser: UserAccountModel?

}
