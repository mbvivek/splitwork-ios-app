//
//  CreateGroupViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/23/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit
import Foundation

class CreateGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextView!
    
    @IBOutlet weak var inviteListTableView: UITableView!
    
    var inviteList = [UserModel]()
    
    var loggedInUser: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _loggedInUserUsername = LoggedInUser.shared.getUser() {
            if let _loggedInUser = Business.shared().users?.getUser(username: _loggedInUserUsername) {
                loggedInUser = _loggedInUser
                return
            }
        }
        Util.showErrorMessage(self, "Invalid Session!")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
        
        // configure the cell
        let member = inviteList[indexPath.row]
        cell.name.text = member.name
        cell.username.text = member.username
        cell.profilePic.image = member.profilePic
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddMemberPopoverViewController" {
            // get the destination view controller
            let controller = segue.destination as! AddMemberPopoverViewController
            // set the members list
            var members = [UserModel]()
            for member in (Business.shared().users?.users)! {
                if(member.username != loggedInUser?.username) {
                    members.append(member)
                }
            }
            controller.members = members
            // set the callback
            controller.callback = { (member: UserModel) -> () in
                for _member in self.inviteList {
                    if(_member.username == member.username) {
                        Util.showErrorMessage(self, "\(member.username!) already exists in the invite list")
                        return
                    }
                }
                self.inviteList.append(member)
                self.inviteListTableView.reloadData()
            }
        }
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
            var memberUsernames = [String]()
            for member in inviteList {
                memberUsernames.append(member.username!)
            }
            GroupService.shared().addGroup(name: _name, desc: _desc, adminUsername: adminUsername, memberUsernames: memberUsernames)
            Util.showSuccessMessage(self, "\"\(_name)\" group is created successfully!")
            dismiss(animated: true, completion: nil)
        } else {
            Util.showErrorMessage(self, "Invalid Session!")
        }
    }
    
}
