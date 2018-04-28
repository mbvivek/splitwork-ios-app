//
//  GroupsTableViewController.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    var detailViewController: GroupDetailViewController!
    var groups = [GroupModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        GroupService.shared().syncGroups(onSync: onSync)
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
                }
            }
        } else {
            Util.showErrorMessage(self, "Invalid session!")
            Util.clearLoggedInUser(self)
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGroupDetailViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                // get the selected group
                let group = groups[indexPath.row]
                // get the detail view controller
                let controller = (segue.destination as! UINavigationController).topViewController as! GroupDetailViewController
                // configure the detail view
                controller.setGroup(groupId: group.id!)
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as? GroupsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of allRoomsTableViewCell.")
        }
        
        let group = groups[indexPath.row]
        cell.groupName.text = group.name
        cell.memberCount.text = String(group.memberUsernames!.count)
        cell.taskCount.text = String(group.taskIds!.count)
        cell.billCount.text = String(group.billIds!.count)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
