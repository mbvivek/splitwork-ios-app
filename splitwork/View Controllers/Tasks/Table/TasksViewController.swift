//
//  TasksViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/19/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    var loggedInUser: UserModel?
    var groups = [GroupModel]()
    var tasks = [[TaskModel]]()
    
    var filteredTasks = [[TaskModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TaskService.shared().syncTasks(onSync: onSync)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func onSync() {
        print("groups synced!")
        DispatchQueue.main.async {
            self.loadData()
        }
    }
    
    func loadData() {
        groups = [GroupModel]()
        if let loggedInUser = Util.getLoggedInUser() {
            for groupId in loggedInUser.groupIds! {
                print("groupId = \(groupId)")
                if let group = Business.shared().groups?.getGroup(id: groupId) {
                    groups.append(group)
                    var groupTasks = [TaskModel]()
                    for taskId in group.taskIds! {
                        if let task = Business.shared().tasks?.getTask(id: taskId) {
                            groupTasks.append(task)
                        }
                    }
                    tasks.append(groupTasks)
                }
            }
            filteredTasks = tasks
            tasksTableView.reloadData()
        } else {
            Util.showErrorMessage(self, "Invalid session!")
            Util.clearLoggedInUser(self)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredTasks = tasks
        } else {
            for (index, groupTasks) in tasks.enumerated() {
                let _groupTasks = groupTasks.filter{ ($0.name?.lowercased().contains(searchText.lowercased()))! || ($0.assignedTo?.lowercased().contains(searchText.lowercased()))! }
                print("_grouptasks = \(_groupTasks.count)")
                filteredTasks[index] = _groupTasks
            }
        }
        tasksTableView.reloadData()
        print("table reloaded..")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tasks[section].count
        return filteredTasks[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groups[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as? TasksTableViewCell else {
            fatalError("The dequeued cell is not an instance of TasksTableViewCell.")
        }
        
        // Configure the cell...
//        cell.taskName.text = tasks[indexPath.section][indexPath.row].name
//        cell.assignedTo.text = tasks[indexPath.section][indexPath.row].assignedTo
//        cell.dueOn.text = Util.dateToStr(date: tasks[indexPath.section][indexPath.row].deadlineDate!)
//        cell.status.text = tasks[indexPath.section][indexPath.row].status
        
        cell.taskName.text = filteredTasks[indexPath.section][indexPath.row].name
        cell.assignedTo.text = filteredTasks[indexPath.section][indexPath.row].assignedTo
        cell.dueOn.text = Util.dateToStr(date: filteredTasks[indexPath.section][indexPath.row].deadlineDate!)
        cell.status.text = filteredTasks[indexPath.section][indexPath.row].status
        
        return cell
    }
     
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
