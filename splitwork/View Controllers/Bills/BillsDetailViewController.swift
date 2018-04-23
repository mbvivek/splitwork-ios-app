//
//  BillsDetailViewController.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/23/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class BillsDetailViewController: UIViewController {

    //MARK: Variables
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setBillLabel(label: String) {
        view.isHidden = false
        loadViewIfNeeded()
        self.name.text = label
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
