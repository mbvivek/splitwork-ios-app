//
//  BillModel+CoreDataProperties.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
//

import Foundation
import CoreData


extension BillModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BillModel> {
        return NSFetchRequest<BillModel>(entityName: "BillModel")
    }

    @NSManaged public var addedTo: NSObject?
    @NSManaged public var amount: Double
    @NSManaged public var desc: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var addedBy: UserAccountModel?
    @NSManaged public var group: GroupModel?

}
