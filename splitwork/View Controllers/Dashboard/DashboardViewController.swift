//
//  DashboardViewController.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var groups: [GroupModel]!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var groupsCount: UILabel!
    @IBOutlet weak var adminCount: UILabel!
    
    @IBOutlet weak var tasksAssignedCount: UILabel!
    @IBOutlet weak var tasksCompletedCount: UILabel!
    
    @IBOutlet weak var billsYouAddedCount: UILabel!
    @IBOutlet weak var billsOthersAddedCount: UILabel!
    
    @IBOutlet weak var youOweAmount: UILabel!
    @IBOutlet weak var othersOweAmount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UserService.shared().syncUsers(onSync: self.onSync)
        GroupService.shared().syncGroups(onSync: self.onSync)
        TaskService.shared().syncTasks(onSync: self.onSync)
        BillService.shared().syncBills(onSync: self.onSync)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //onSync()
    }
    
    func onSync() {
        DispatchQueue.main.async {
            self.loadData()
        }
    }
    
    func loadData() {
        
        // groups
        groups = [GroupModel]()
        if let loggedInUser = Util.getLoggedInUser() {
            
            name.text = loggedInUser.name
            username.text = loggedInUser.username
            profilePic.image = loggedInUser.profilePic
            
            for groupId in loggedInUser.groupIds! {
                print("groupId = \(groupId)")
                if let group = Business.shared().groups?.getGroup(id: groupId) {
                    groups.append(group)
                }
            }
            
            var groupAdminCount = 0
            var completedCount = 0
            var assignedCount = 0
            var youAdded = 0
            var addedToYou = 0
            if let loggedInUser = Util.getLoggedInUser() {
                
                // group count
                groupsCount.text = String(loggedInUser.groupIds!.count)
                
                // admin group count
                if let groupIds = loggedInUser.groupIds{
                    for groupId in groupIds {
                        if let group = Business.shared().groups?.getGroup(id: groupId) {
                            if(group.adminUsername == loggedInUser.username) {
                                groupAdminCount += 1
                            }
                        }
                    }
                }
                
                // tasks count
                for task in Business.shared().tasks!.tasks {
                    if task.assignedTo == loggedInUser.username {
                        assignedCount += 1
                        if task.status == "Completed" {
                            completedCount += 1
                        }
                    }
                }
                
                // bills count
                for bill in Business.shared().bills!.bills {
                    if(bill.addedBy == loggedInUser.username) {
                        youAdded += 1
                    }
                    if(bill.addedTo?.contains(loggedInUser.username!))! {
                        addedToYou += 1
                    }
                }
                
                loadViewIfNeeded()
                
                adminCount.text = "\(groupAdminCount)"
                tasksCompletedCount.text = "\(completedCount)"
                tasksAssignedCount.text = "\(assignedCount)"
                
                billsYouAddedCount.text = "\(youAdded)"
                billsOthersAddedCount.text = "\(addedToYou)"
                
                
                
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
    
    @IBAction func changeProfilePicAction(_ sender: UILongPressGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        if let _loggedInUserUsername = LoggedInUser.shared.getUser() {
            if let _loggedInUser = Business.shared().users?.getUser(username: _loggedInUserUsername) {
                UserService.shared().updateProfilePic(userId: _loggedInUser.id!, profilePic: newImage)
            }
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        
        // clear the LoggedInUser in core data
        LoggedInUser.shared.clear()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(loginViewController, animated:true, completion:nil)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: Actions
    
    
}
