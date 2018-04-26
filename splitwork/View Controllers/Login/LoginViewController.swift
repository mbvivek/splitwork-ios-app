//
//  ViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/16/18.
//  Copyright © 2018 Vivek Madhusudan Badrinarayan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        passwordTextField.isSecureTextEntry = true
        UserService.shared().addUser(id: String(Date().hashValue), username: "swathikc", password: "456", name: "Swathi", email: "swathi.kc", phone: "9876543210")
        UserService.shared().syncUsers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

