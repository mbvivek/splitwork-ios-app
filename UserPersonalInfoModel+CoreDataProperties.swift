//
//  UserPersonalInfoModel+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension UserPersonalInfoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPersonalInfoModel> {
        return NSFetchRequest<UserPersonalInfoModel>(entityName: "UserPersonalInfoModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var profilePic: NSObject?

}
