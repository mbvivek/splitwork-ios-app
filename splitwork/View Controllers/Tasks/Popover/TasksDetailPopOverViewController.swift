//
//  TasksDetailPopOverViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/21/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class TasksDetailPopOverViewController: UIViewController {
    
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var assignedTo: UILabel!
    @IBOutlet weak var assignedOn: UILabel!
    @IBOutlet weak var dueOn: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var popoverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurBackground()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func blurBackground() {
        self.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
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
