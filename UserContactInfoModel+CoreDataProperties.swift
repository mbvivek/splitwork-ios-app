//
//  UserContactInfoModel+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension UserContactInfoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserContactInfoModel> {
        return NSFetchRequest<UserContactInfoModel>(entityName: "UserContactInfoModel")
    }

    @NSManaged public var email: String?
    @NSManaged public var phone: String?

}
