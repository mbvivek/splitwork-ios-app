//
//  UserService.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class UserService {
    
    let httpService: HTTPService
    
    private static var sharedService: UserService = {
        let service = UserService()
        return service
    }()
    
    private init() {
        self.httpService = HTTPService.shared()
        print("UserService initialized..")
    }
    
    class func shared() -> UserService {
        return sharedService
    }
    
    
    
    
}
