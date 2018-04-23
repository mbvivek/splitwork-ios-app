//
//  GroupDetailViewController.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController {
    
    //MARK: Variables
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupDescription: UITextView!
    
    @IBOutlet weak var totalMemberCount: UILabel!
    @IBOutlet weak var totalTaskCount: UILabel!
    @IBOutlet weak var totalBillCount: UILabel!
    
    @IBOutlet weak var yourPendingTaskCount: UILabel!
    @IBOutlet weak var yourAssignedTaskCount: UILabel!
    @IBOutlet weak var yourCompletedTaskCount: UILabel!
    @IBOutlet weak var yourMissedTaskCount: UILabel!
    
    @IBOutlet weak var amountYouOwe: UILabel!
    @IBOutlet weak var amountYouAreOwed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func setGroupLabel(label: String) {
        view.isHidden = false
        loadViewIfNeeded()
        self.groupName.text = label
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
