//
//  AddBillViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/28/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController {

    var group: GroupModel?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var amount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setGroup(groupId: String) {
        
        loadViewIfNeeded()
        if let group = Business.shared().groups?.getGroup(id: groupId) {
            self.group = group
        }
        
    }
    
    
    @IBAction func AddBillButtonAction(_ sender: UIButton) {
        
        if let loggedInUser = Util.getLoggedInUser() {
            
            let billName = name.text!
            let billDesc = desc.text!
            let billAmount = amount.text!
            
            if(billName == "" || billDesc == "" || billAmount == "") {
                Util.showErrorMessage(self, "Please fill all the fields!")
                return
            }
            
            // check bill amount
            if(!Util.isDouble(testString: billAmount)) {
                Util.showErrorMessage(self, "Invalid Amount")
                return
            }
            
            let _billAmount = Double(billAmount)!
            if(_billAmount < Double(0)) {
                Util.showErrorMessage(self, "Invalid Amount")
                return
            }
            
            let addedBy = loggedInUser.username!
            let addedTo = group!.memberUsernames
            let groupId = group!.id
            
            print("billName=\(billName)")
            print("billDesc=\(billDesc)")
            print("addedBy=\(addedBy)")
            print("addedTo=\(addedTo)")
            print("amount=\(_billAmount)")
            print("groupId=\(groupId)")
            
            
            // add bill
            BillService.shared().addBill(name: billName, desc: billDesc, addedBy: addedBy, addedTo: addedTo!, amount: _billAmount, date: Date(), groupId: groupId!)
            
            Util.showSuccessMessage(self, "Bill added successfully!")
            name.text = ""
            desc.text = ""
            amount.text = ""
            
            
        } else {
            Util.showErrorMessage(self, "Invalid Session!")
            Util.clearLoggedInUser(self)
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
