//
//  GroupService.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/26/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class GroupService {
    
    let httpService: HTTPService
    
    private static var sharedService: GroupService = {
        let service = GroupService()
        return service
    }()
    
    private init() {
        self.httpService = HTTPService.shared()
        print("GroupService initialized..")
    }
    
    class func shared() -> GroupService {
        return sharedService
    }
    
    func syncGroups(onSync: (() -> ())?) {
        
        Business.shared().groups?.clear()
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            
            if(error != "") {
                print("Error in GroupService.suncGroups()")
            } else {
                if let groups = data["data"] as? [String: Any] {
                    print("received groups from server, group count = \(groups.count)")
                    for _group in groups {
                        
                        let group = _group.value as! [String: Any]
                        
                        let id = _group.key
                        let name = group["name"] as! String
                        let desc = group["desc"] as! String
                        let adminUsername = group["adminUsername"] as! String
                        
                        var memberUsernames = [String]()
                        if let _memberUsernames = group["memberUsernames"] as? [String: Any] {
                            for _memberUsername in _memberUsernames {
                                if let __memberUsername = _memberUsername.value as? [String: Any] {
                                    memberUsernames.append(__memberUsername["username"] as! String)
                                }
                            }
                        }
                        
                        var taskIds = [String]()
                        if let _taskIds = group["taskIds"] as? [String: Any] {
                            print("_taskIds=  \(_taskIds)")
                            for _taskId in _taskIds {
                                if let __taskId = _taskId.value as? [String: Any] {
                                    taskIds.append(__taskId["taskId"] as! String)
                                }
                            }
                        }
                        
                        var billIds = [String]()
                        if let _billIds = group["billIds"] as? [String: Any] {
                            for _billId in _billIds {
                                if let __billId = _billId.value as? [String: Any] {
                                    billIds.append(__billId["billId"] as! String)
                                }
                            }
                        }
                        
                        // add group to model
                        Business.shared().groups?.addGroup(id: id, name: name, desc: desc, adminUsername: adminUsername, memberUsernames: memberUsernames, taskIds: taskIds, billIds: billIds)
                    }
                }
            }
            print("synced groups from server, group count = \((Business.shared().groups?.groups.count)!)")
            onSync?()
        }
        httpService.get(url: "groups", completionHandler: completionHandler)
    }
    
    func addGroup(name: String, desc: String, adminUsername: String, memberUsernames: [String]) {
        
        var group = [String: Any]()
        group["name"] = name
        group["desc"] = desc
        group["adminUsername"] = adminUsername
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding group to firebase, error = \(error)")
            } else {
                print("Success in adding group to firebase")
                print("data = \(data)")
                if let res = data["data"] as? [String: Any] {
                    if let groupId = res["name"] as? String {
                        print("groupId = \(groupId)")
                        self.addMemberToGroup(groupId: groupId, memberUsername: adminUsername)
                        for memberUsername in memberUsernames {
                            self.addMemberToGroup(groupId: groupId, memberUsername: memberUsername)
                        }
                    }
                }
                self.syncGroups(onSync: nil)
            }
        }
        httpService.post(url: "groups", data: group, completionHandler: completionHandler)
    }
    
    func addMemberToGroup(groupId: String, memberUsername: String) {
        
        var member = [String: Any]()
        member["username"] = memberUsername
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error adding member to group in firebase, error = \(error)")
            } else {
                print("Success in adding member to group in firebase")
                if let user = Business.shared().users?.getUser(username: memberUsername) {
                    let userId = user.id
                    // add group to user
                    UserService.shared().addGroupToUser(userId: userId!, groupId: groupId)
                }
                self.syncGroups(onSync: nil)
            }
        }
        httpService.post(url: "groups/\(groupId)/memberUsernames", data: member, completionHandler: completionHandler)
    }
    
    func addTaskToGroup(groupId: String, taskId: String) {
        
        var task = [String: Any]()
        task["taskId"] = taskId
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error adding task to group in firebase, error = \(error)")
            } else {
                print("Success in adding task to group in firebase")
                self.syncGroups(onSync: nil)
            }
        }
        httpService.post(url: "groups/\(groupId)/taskIds", data: task, completionHandler: completionHandler)
    }
    
    func addBillToGroup(groupId: String, billId: String) {
        
        var bill = [String: Any]()
        bill["billId"] = billId
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error adding bill to group in firebase, error = \(error)")
            } else {
                print("Success in adding bill to group in firebase")
                self.syncGroups(onSync: nil)
            }
        }
        httpService.post(url: "groups/\(groupId)/billIds", data: bill, completionHandler: completionHandler)
    }
    
}
