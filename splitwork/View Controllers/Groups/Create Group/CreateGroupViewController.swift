//
//  CreateGroupViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/23/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupDescription: UITextView!
    
    @IBOutlet weak var inviteListTableView: UITableView!
    
    var invitedMembers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invitedMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddMemberPopoverTableViewCell", for: indexPath) as? AddMemberPopoverTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AddMemberPopoverTableViewCell.")
        }
        
        let member = invitedMembers[indexPath.row]
        
        // configure the cell
        cell.name.text = member
        
        return cell
    }
    
    
    @IBAction func checkAvailabilityButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func addMemberButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func createGroupButtonAction(_ sender: Any) {
    }
    
}
