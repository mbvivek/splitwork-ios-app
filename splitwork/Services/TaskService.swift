//
//  TaskService.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/27/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation
import UIKit

class TaskService {
    
    let httpService: HTTPService
    
    private static var sharedService: TaskService = {
        let service = TaskService()
        return service
    }()
    
    private init() {
        self.httpService = HTTPService.shared()
        print("CardService initialized..")
    }
    
    class func shared() -> TaskService {
        return sharedService
    }

    func syncTasks(onSync: (() -> ())?) {
        Business.shared().tasks?.clear()
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in TaskService.syncUsers()")
            } else {
                if let tasks = data["data"] as? [String:Any] {
                    print("received tasks from server, task count \(tasks.count)")
                    for _task in tasks {
                        
                        let task = _task.value as! [String: Any]
                        let id = _task.key
                        
                        let name = task["name"] as! String
                        let desc = task["desc"] as! String
                        let assignedTo = task["assignedTo"] as! String
                        let assignedDate = task["assignedDate"] as! String
                        let deadlineDate = task["deadlineDate"] as! String
                        let completionDate = task["completionDate"] as! String
                        let groupId = task["groupId"] as! String
                        let status = task["status"] as! String
                        let completionPercentage = task["completionPercentage"] as! String
                        
                        let _assignedDate = Util.strToDate(dateInStr: assignedDate)
                        let _deadlineDate = Util.strToDate(dateInStr: deadlineDate)
                        let _completionDate = Util.strToDate(dateInStr: completionDate)
                        
                        let _completionPercentage = Double(completionPercentage)
                        
                        // add task to model
                        Business.shared().tasks?.addTask(id: id, name: name, desc: desc, assignedTo: assignedTo, assignedDate: _assignedDate!, deadlineDate: _deadlineDate!, completionDate: _completionDate!, groupId: groupId, status: status, completionPercentage: _completionPercentage!)
                    }
                }
            }
            print("synced tasks from server, task count = \((Business.shared().tasks?.tasks.count)!)")
            onSync?()
        }
        httpService.get(url: "tasks", completionHandler: completionHandler)
    }
    
    func addTask(groupId: String, name: String, desc: String, assignedTo: String, deadlineDate: Date) {
        
        var task = [String: Any]()
        task["groupId"] = groupId
        task["name"] = name
        task["desc"] = desc
        task["assignedTo"] = assignedTo
        task["assignedDate"] = Util.dateToStr(date: Date())
        task["deadlineDate"] = Util.dateToStr(date: deadlineDate)
        task["completionDate"] = Util.dateToStr(date: deadlineDate)
        task["status"] = "Assigned"
        task["completionPercentage"] = "0.0"
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding task to firebase, error = \(error)")
            } else {
                print("Success in adding task to firebase")
                print("data = \(data)")
                if let res = data["data"] as? [String: Any] {
                    if let taskId = res["name"] as? String {
                        print("taskId = \(taskId)")
                        // add the taskId to group
                        GroupService.shared().addTaskToGroup(groupId: groupId, taskId: taskId)
                    }
                }
                self.syncTasks(onSync: nil)
            }
        }
        httpService.post(url: "tasks", data: task, completionHandler: completionHandler)
    }
    
    func updateTaskStatus(taskId: String, status: String) {
        var task = [String: Any]()
        task["status"] = status
        
        let completionHandler: (String, [String: Any]) -> () = { error, data in
            if(error != "") {
                print("Error in adding task to firebase, error = \(error)")
            } else {
                print("Success in adding task to firebase")
                self.syncTasks(onSync: nil)
            }
        }
        httpService.patch(url: "tasks/\(taskId)", data: task, completionHandler: completionHandler)
    }
    
}
