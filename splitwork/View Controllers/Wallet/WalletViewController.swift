//
//  WalletViewController.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//
import UIKit

class WalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var details = ["Vivek", "Spoorthi", "Swathi", "Nidhi", "Vivek", "Spoorthi", "Swathi", "Nidhi"]
    var transactions = ["Vivek", "Spoorthi", "Swathi", "Nidhi", "Vivek", "Spoorthi", "Swathi", "Nidhi"]
    
    
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var transactionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (tableView == detailTableView) {
            return details.count
        }
        else {
            return transactions.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == detailTableView) {
            let cellIdentifier = "DetailTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DetailTableViewCell  else {
                fatalError("The dequeued cell is not an instance of DetailTableViewCell.")
            }
            
            let detail = details[indexPath.row]
            cell.memberName.text = detail
            cell.amount.text = "$25"
            return cell
        }
        else {
            let cellIdentifier = "TransactionTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TransactionTableViewCell  else {
                fatalError("The dequeued cell is not an instance of TransactionTableViewCell.")
            }
            
            let transaction = transactions[indexPath.row]
            cell.memberName.text = transaction
            cell.paidAmount.text = "$25"
            return cell
        }
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
