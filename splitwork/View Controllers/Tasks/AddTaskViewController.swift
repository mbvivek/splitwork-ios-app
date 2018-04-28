//
//  AddTaskViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/27/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var groupId: String?
    var memberUsernames = [String]()
    var selectedMember: String?
    var deadline: Date?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var assignedTo: UIPickerView!
    @IBOutlet weak var deadlineDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deadlineDate.minimumDate = Date()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return memberUsernames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "@\(memberUsernames[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMember = memberUsernames[row]
    }
    
    func setGroup(groupId: String) {
        self.groupId = groupId
        if let group = Business.shared().groups?.getGroup(id: groupId) {
            self.memberUsernames = group.memberUsernames!
        }
        loadViewIfNeeded()
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        deadline = deadlineDate.date
        
        let _name = name.text!
        let _desc = desc.text!
        
        if(_name == "" || _desc == "") {
            Util.showErrorMessage(self, "Please fill all the fields!")
            return
        }
        
        if(selectedMember == nil) {
            Util.showErrorMessage(self, "Please select a member!")
            return
        }
        
        // add the task
        TaskService.shared().addTask(groupId: self.groupId!, name: _name, desc: _desc, assignedTo: selectedMember!, deadlineDate: deadline!)
        Util.showSuccessMessage(self, "Task added successfully!")
        
        name.text = ""
        desc.text = ""
        deadlineDate.date = Date()
        
    }
    
}
