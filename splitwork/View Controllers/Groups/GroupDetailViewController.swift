//
//  GroupDetailViewController.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Variables
    
    var groupId: String?
    var group: GroupModel?
    var tasks = [TaskModel]()
    var bills = [BillModel]()
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupDescription: UITextView!
    
    @IBOutlet weak var totalMemberCount: UILabel!
    @IBOutlet weak var totalTaskCount: UILabel!
    @IBOutlet weak var totalBillCount: UILabel!
    
    @IBOutlet weak var yourAssignedTaskCount: UILabel!
    @IBOutlet weak var yourCompletedTaskCount: UILabel!
    @IBOutlet weak var yourMissedTaskCount: UILabel!
    

    @IBOutlet weak var billsAddedByYouCount: UILabel!
    @IBOutlet weak var billsAddedToYouCount: UILabel!
    @IBOutlet weak var amountYouOwe: UILabel!
    @IBOutlet weak var amountYouAreOwed: UILabel!
    
    @IBOutlet weak var addTaskButton: UIButton!
    
    @IBOutlet weak var addMemberButton: UIButton!
    @IBOutlet weak var membersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GroupService.shared().syncGroups(onSync: _onSync)
        TaskService.shared().syncTasks(onSync: onSync)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.group != nil) {
            return group!.memberUsernames!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupDetailMemberTableViewCell", for: indexPath) as? GroupDetailMemberTableViewCell  else {
            fatalError("The dequeued cell is not an instance of GroupDetailMemberTableViewCell.")
        }
        
        let member = Business.shared().users?.getUser(username: (group?.memberUsernames![indexPath.row])!)
        cell.name.text = member?.name
        cell.profilePic.image = member?.profilePic
        
        if(self.group?.adminUsername == member?.username) {
            cell.role.isHidden = false
            cell.role.text = "Admin"
        }
        
        return cell
    }
    
    func _onSync() {
        DispatchQueue.main.async {
            self.onSync()
        }
    }
    
    func onSync() {
        print("groups synced!")
        DispatchQueue.main.async {
            self.loadData()
        }
    }
    
    func loadData() {
        tasks = [TaskModel]()
        bills = [BillModel]()
        if let loggedInUser = Util.getLoggedInUser() {
            if let group = Business.shared().groups?.getGroup(id: groupId!) {
                
                if(loggedInUser.username == group.adminUsername) {
                    addMemberButton.isHidden = false
                }
                
                self.group = group
                
                if(loggedInUser.username == group.adminUsername) {
                    addTaskButton.isHidden = false
                }
                
                groupName.text = group.name
                groupDescription.text = group.desc
                for taskId in group.taskIds! {
                    if let task = Business.shared().tasks?.getTask(id: taskId) {
                        self.tasks.append(task)
                    }
                }
                for billId in group.billIds! {
                    if let bill = Business.shared().bills?.getBill(id: billId) {
                        self.bills.append(bill)
                    }
                }
                totalMemberCount.text = String(group.memberUsernames!.count)
                totalTaskCount.text = String(group.taskIds!.count)
                totalBillCount.text = String(group.billIds!.count)
                
                yourAssignedTaskCount.text = String(getAssignedTasksCount(tasks: tasks))
                yourCompletedTaskCount.text = String(getCompletedTasksCount(tasks: tasks))
                yourMissedTaskCount.text = String(getMissedTasksCount(tasks: tasks))
                
                billsAddedByYouCount.text = String(getBillsAddedByYouCount(bills: bills, loggedInUser: loggedInUser))
                billsAddedToYouCount.text = String(getBillsAddedToYouCount(bills: bills, loggedInUser: loggedInUser))
                
                loadViewIfNeeded()
                membersTableView.reloadData()
            }
        } else {
            Util.showErrorMessage(self, "Invalid session!")
            Util.clearLoggedInUser(self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setGroup(groupId: String) {
        view.isHidden = false
        loadViewIfNeeded()
        self.groupId = groupId
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTaskViewController" {
            // get the detail view controller
            let controller = segue.destination as! AddTaskViewController
            // configure the detail view
            controller.setGroup(groupId: self.groupId!)
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
        
        if segue.identifier == "toAddBillViewController" {
            // get the detail view controller
            let controller = segue.destination as! AddBillViewController
            // configure the detail view
            controller.setGroup(groupId: self.groupId!)
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
        
        if segue.identifier == "toAddMemberPopoverViewController" {
            // get the destination view controller
            let controller = segue.destination as! AddMemberPopoverViewController
            // set the members list
            var members = [UserModel]()
            for member in (Business.shared().users?.users)! {
                if(member.username != Util.getLoggedInUser()?.username) {
                    members.append(member)
                }
            }
            controller.members = members
            // set the callback
            controller.callback = { (member: UserModel) -> () in
                for _member in self.group!.memberUsernames! {
                    if(_member == member.username) {
                        Util.showErrorMessage(self, "\(member.username!) already exists in the group")
                        return
                    }
                }
                GroupService.shared().addMemberToGroup(groupId: (self.group?.id)!, memberUsername: member.username!)
                self.group?.memberUsernames?.append(member.username!)
                self.membersTableView.reloadData()
            }
        }
        
    }
    
    
    func getAssignedTasksCount(tasks: [TaskModel]) -> Int {
        var count = 0
        for task in tasks {
            if(task.status == "Assigned") {
                count += 1
            }
        }
        return count
    }
    
    func getCompletedTasksCount(tasks: [TaskModel]) -> Int {
        var count = 0
        for task in tasks {
            if(task.status == "Completed") {
                count += 1
            }
        }
        return count
    }
    
    func getMissedTasksCount(tasks: [TaskModel]) -> Int {
        var count = 0
        for task in tasks {
            if(task.status == "Missed") {
                count += 1
            }
        }
        return count
    }
    
    func getBillsAddedByYouCount(bills: [BillModel], loggedInUser: UserModel) -> Int {
        var count = 0
        for bill in bills {
            if(bill.addedBy == loggedInUser.username) {
                count += 1
            }
        }
        return count
    }
    
    func getBillsAddedToYouCount(bills: [BillModel], loggedInUser: UserModel) -> Int {
        return (bills.count - getBillsAddedByYouCount(bills: bills, loggedInUser: loggedInUser))
    }

}
