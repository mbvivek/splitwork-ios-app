//
//  Business.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class Business {
    
    var users: Users?
    var groups: Groups?
    var tasks: Tasks?
    var bills: Bills?
    var payments: Payments?
    
    private static var sharedBusiness: Business = {
        let business = Business()
        return business
    }()
    
    private init() {
        self.users = Users()
        self.groups = Groups()
        self.tasks = Tasks()
        self.bills = Bills()
        self.payments = Payments()
    }
    
    class func shared() -> Business {
        return sharedBusiness
    }
    
}
