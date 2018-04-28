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
    
    var bill: BillModel?
    
    @IBOutlet weak var billName: UILabel!
    @IBOutlet weak var billAmount: UILabel!
    @IBOutlet weak var billDate: UILabel!
    
    @IBOutlet weak var addedByProfilePic: UIImageView!
    @IBOutlet weak var addedByUser: UILabel!
    @IBOutlet weak var addedByUserAmount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setBill(bill: BillModel) {
        view.isHidden = false
        loadViewIfNeeded()
        self.bill = bill
        billName.text = bill.name
        billAmount.text = String("$\(bill.amount)")
        billDate.text = Util.dateToStr(date: bill.date!)
        
        if let user = Business.shared().users?.getUser(username: bill.addedBy!) {
            addedByProfilePic.image = user.profilePic
            addedByUser.text = user.name
            addedByUserAmount.text = String(bill.amount)
        }
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (bill?.addedTo!.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BillSplitTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BillSplitTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BillSplitTableViewCell.")
        }
        
        if let user = Business.shared().users?.getUser(username: (bill?.addedTo![indexPath.row])!) {
            cell.memberName.text = user.name
            cell.profilePic.image = user.profilePic
        }
        cell.amount.text = String(bill!.amount/Double(bill!.addedTo!.count))
        
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
