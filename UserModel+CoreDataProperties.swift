//
//  UserModel+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension UserModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserModel> {
        return NSFetchRequest<UserModel>(entityName: "UserModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var contactInfo: UserContactInfoModel?
    @NSManaged public var paymentInfo: UserPaymentInfoModel?
    @NSManaged public var personalInfo: UserPersonalInfoModel?

}
