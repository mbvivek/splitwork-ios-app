//
//  ViewTaskViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/28/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class ViewTaskViewController: UIViewController {
    
    
    var task: TaskModel?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var assignedToProfilePic: UIImageView!
    @IBOutlet weak var assignedToName: UILabel!
    @IBOutlet weak var assignedToUsername: UILabel!
    @IBOutlet weak var assignedDate: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var markCompleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func markCompleteButtonAction(_ sender: UIButton) {
        TaskService.shared().updateTaskStatus(taskId: (task?.id)!, status: "Completed")
        Util.showSuccessMessage(self, "Task updated successfully!")
        task?.status = "Completed"
        markCompleteButton.isHidden = true
        loadViewIfNeeded()
    }
    
    func setTask(task: TaskModel) {
        self.task = task
        
        loadViewIfNeeded()
        
        name.text = task.name
        desc.text = task.desc
        assignedToUsername.text = task.assignedTo
        assignedDate.text = Util.dateToStr(date: task.assignedDate!)
        dueDate.text = Util.dateToStr(date: task.deadlineDate!)
        status.text = task.status
        
        if let user = Business.shared().users?.getUser(username: task.assignedTo!) {
            assignedToName.text = user.name
            assignedToProfilePic.image = user.profilePic
        }
        
        if let loggedInUser = Util.getLoggedInUser() {
            if(task.assignedTo == loggedInUser.username && task.status == "Assigned") {
                markCompleteButton.isHidden = false
            }
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
