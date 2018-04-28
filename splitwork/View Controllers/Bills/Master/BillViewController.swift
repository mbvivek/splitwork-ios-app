//
//  BillViewController.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/23/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class BillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var detailViewController: BillsDetailViewController!
    var bills = [BillModel]()
    var loggedInUser: UserModel?
    //MARK: Variables
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BillService.shared().syncBills(onSync: onSync)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func onSync() {
        DispatchQueue.main.async {
            self.loadData()
        }
    }
    
    func loadData() {
        bills = [BillModel]()
        if let _loggedInUser = Util.getLoggedInUser() {
            loggedInUser = _loggedInUser
            for groupId in (loggedInUser?.groupIds)! {
                if let group = Business.shared().groups?.getGroup(id: groupId) {
                    for billId in group.billIds! {
                        if let bill = Business.shared().bills?.getBill(id: billId) {
                            if(bill.addedTo?.contains((loggedInUser?.username)!))! {
                                bills.append(bill)
                            }
                        }
                    }
                }
            }
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBillsDetailViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                // get the selected group
                let bill = bills[indexPath.row]
                // get the detail view controller
                let controller = (segue.destination as! UINavigationController).topViewController as! BillsDetailViewController
                // configure the detail view
                controller.setBill(bill: bill)
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bills.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BillsTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BillsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of allRoomsTableViewCell.")
        }
        
        let bill = bills[indexPath.row]
        cell.billNames.text = bill.name
        
        if let addedByUser = Business.shared().users?.getUser(username: bill.addedBy!) {
            cell.addedBy.text = addedByUser.name
        }

        cell.oweLabel.text = "You are owed"
        
        cell.oweAmount.text = String(bill.amount/Double(bill.addedTo!.count))
        
        if let group = Business.shared().groups?.getGroup(id: bill.groupId!) {
            cell.group.text = group.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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
