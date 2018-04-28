//
//  ViewTaskViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/28/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class ViewTaskViewController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var assignedToProfilePic: UIImageView!
    @IBOutlet weak var assignedToName: UILabel!
    @IBOutlet weak var assignedToUsername: UILabel!
    @IBOutlet weak var assignedDate: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
