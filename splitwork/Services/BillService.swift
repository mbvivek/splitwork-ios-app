//
//  BillService.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/28/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class BillService {
    
    let httpService: HTTPService
    
    private static var sharedService: BillService = {
        let service = BillService()
        return service
    }()
    
    private init() {
        self.httpService = HTTPService.shared()
        print("BillService initialized..")
    }
    
    class func shared() -> BillService {
        return sharedService
    }
    
    func syncBills(onSync: (() -> ())?) {
        Business.shared().bills?.clear()
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in BillService.syncBills()")
            } else {
                if let bills = data["data"] as? [String:Any] {
                    print("received bills from server, bill count \(bills.count)")
                    for _bill in bills {
                        
                        let bill = _bill.value as! [String: Any]
                        let id = _bill.key
                        
                        let name = bill["name"] as! String
                        let desc = bill["desc"] as! String
                        let addedBy = bill["addedBy"] as! String
                        let date = bill["date"] as! String
                        let amount = bill["amount"] as! String
                        let groupId = bill["groupId"] as! String
                        
                        var addedTo = [String]()
                        if let _memberUsernames = bill["addedTo"] as? [String: Any] {
                            for _memberUsername in _memberUsernames {
                                if let __memberUsername = _memberUsername.value as? [String: Any] {
                                    addedTo.append(__memberUsername["username"] as! String)
                                }
                            }
                        }
                        
                        // add bill to model
                        Business.shared().bills?.addBill(id: id, name: name, desc: desc, addedBy: addedBy, addedTo: addedTo, amount: Double(amount)!, date: Util.strToDate(dateInStr: date)!, groupId: groupId)
                    }
                }
            }
            print("synced bills from server, bill count = \((Business.shared().bills?.bills.count)!)")
            onSync?()
        }
        httpService.get(url: "bills", completionHandler: completionHandler)
    }
    
    func addBill(name: String, desc: String, addedBy: String, addedTo: [String], amount: Double, date: Date, groupId: String) {
        
        var bill = [String: Any]()
        bill["name"] = name
        bill["desc"] = desc
        bill["addedBy"] = addedBy
        bill["amount"] = String(amount)
        bill["date"] = Util.dateToStr(date: date)
        bill["groupId"] = groupId
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding bill to firebase, error = \(error)")
            } else {
                print("Success in adding bill to firebase")
                print("data = \(data)")
                if let res = data["data"] as? [String: Any] {
                    if let billId = res["name"] as? String {
                        print("billId = \(billId)")
                        GroupService.shared().addBillToGroup(groupId: groupId, billId: billId)
                        for memberUsername in addedTo {
                            self.addMemberToBill(billId: billId, username: memberUsername)
                        }
                    }
                }
                self.syncBills(onSync: nil)
            }
        }
        httpService.post(url: "bills", data: bill, completionHandler: completionHandler)
    }
    
    func addMemberToBill(billId: String, username: String) {
        var member = [String: Any]()
        member["username"] = username
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding member to bill to firebase, error = \(error)")
            } else {
                print("Success in adding member to bill to firebase")
                print("data = \(data)")
                self.syncBills(onSync: nil)
            }
        }
        httpService.post(url: "bills/\(billId)/addedTo", data: member, completionHandler: completionHandler)
    }
    
}
