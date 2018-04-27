//
//  CreateGroupViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/23/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextView!
    
    @IBOutlet weak var inviteListTableView: UITableView!
    
    var inviteList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inviteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateGroupInviteListTableViewCell", for: indexPath) as? CreateGroupInviteListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CreateGroupInviteListTableViewCell.")
        }
        
        let member = inviteList[indexPath.row]
        
        // configure the cell
        cell.name.text = member
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddMemberPopoverViewController" {
            // get the destination view controller
            let controller = segue.destination as! AddMemberPopoverViewController
            // set the callback
            controller.callback = { (member: String) -> () in
                
                if self.inviteList.contains(member) {
                    Util.showErrorMessage(self, "'\(member)' already exists in the invite list!")
                    return
                }
                self.inviteList.append(member)
                self.inviteListTableView.reloadData()
            }
        }
    }
    
    func ifMemberExistsInInviteList(_ member: String) -> Bool {
        return inviteList.contains(member)
    }
    
    @IBAction func checkAvailabilityButtonAction(_ sender: Any) {
    }
    
    @IBAction func addMemberButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func createGroupButtonAction(_ sender: Any) {
        
        let _name = name.text!
        let _desc = desc.text!
        
        if(_name == "" || _desc == "") {
            Util.showErrorMessage(self, "Please fill all the fields!")
            return
        }
        
        if let adminUsername = LoggedInUser.shared.getUser() {
            GroupService.shared().addGroup(name: _name, desc: _desc, adminUsername: adminUsername, memberUsernames: inviteList)
            Util.showSuccessMessage(self, "\"\(name)\" group is created successfully!")
        } else {
            Util.showErrorMessage(self, "Invalid Session!")
        }
        
        
        
    }
    
    
    
}
