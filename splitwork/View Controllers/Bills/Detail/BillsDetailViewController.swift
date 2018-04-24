//
//  BillsDetailViewController.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/23/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class BillsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var billSplits: [String]!
    
    //MARK: Variables
    
    @IBOutlet weak var billName: UILabel!
    @IBOutlet weak var billAmount: UILabel!
    @IBOutlet weak var billDate: UILabel!
    @IBOutlet weak var addedBy: UILabel!
    @IBOutlet weak var paidAmount: UILabel!
    @IBOutlet weak var tableView: AddMemberPopoverTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billSplits = ["Vivek", "Spoorthi", "Swathi", "Nidhi"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setBillLabel(label: String) {
        view.isHidden = false
        loadViewIfNeeded()
        self.billName.text = label
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return billSplits.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BillSplitTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BillSplitTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BillSplitTableViewCell.")
        }
        
        let billSplit = billSplits[indexPath.row]
        cell.memberName.text = billSplit
        cell.amount.text = "25.00"
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
