//
//  ViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/16/18.
//  Copyright © 2018 Vivek Madhusudan Badrinarayan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginViewController - viewDidLoad")
        
        UserService.shared().syncUsers(onSync: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        password.isSecureTextEntry = true
    }
    
    // MARK: - Notification oberserver methods
    
    @objc func didBecomeActive() {
        print("LoginViewController - didBecomeActive")
        // check if LoggedInUser exists
        if let _loggedInUserUsername  = LoggedInUser.shared.getUser() {
            print("loggedInUser = \(_loggedInUserUsername)")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let tabBarcontroller = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
            self.present(tabBarcontroller, animated:true, completion:nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        let _username = username.text!
        let _password = password.text!
        
        // check if both fields are filled
        if(_username == "" || _password == "") {
            Util.showErrorMessage(self, "Please fill both fields!")
            return
        }
        
        // get the user with this username and verify credentials
        if let user = Business.shared().users?.getUser(username: _username) {
            if(user.password == String(_password.hashValue)) {
                // valid credentials
                LoggedInUser.shared.addUser(username: _username)
                self.performSegue(withIdentifier: "toDashboard", sender: nil)
                return
            }
        }
        Util.showErrorMessage(self, "Invalid Credentials!")
    }
    
}

