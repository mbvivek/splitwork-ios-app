//
//  RegisterViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/26/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signupButtonAction(_ sender: Any) {
        
        let _name = self.name.text!
        let _email = self.email.text!
        let _phone = self.phone.text!
        let _username = self.username.text!
        let _password = self.password.text!
        let _confirmPassword = self.confirmPassword.text!
        
        // check if all fields  are filled
        if(_name == "" || _email == "" || _phone == "" || _username == "" || _password == "" || _confirmPassword == "") {
            Util.showErrorMessage(self, "Please fill all fields!")
            return
        }
        
        // check if email is valid
        if(!Util.isValidEmail(testEmail: _email)) {
            Util.showErrorMessage(self, "Invalid Email!")
            return
        }
        
        // check if phone is valid
        if(!Util.isValidPhone(testPhone: _phone)) {
            Util.showErrorMessage(self, "Invalid Phone!")
            return
        }
        
        // check if passwords are atleast 6 characters long
        if(_password.count < 6) {
            Util.showErrorMessage(self, "Password should be at least 6 characters long!")
            return
        }
        
        // check if passwords match
        if(_password != _confirmPassword) {
            Util.showErrorMessage(self, "Passwords do not match!")
            return
        }
        
        // check if this username already exists
        if (Business.shared().users?.getUser(username: _username)) != nil {
            Util.showErrorMessage(self, "This Username is already taken!")
            return
        }
        
        // add the user
        UserService.shared().addUser(username: _username, password: _password, name: _name, email: _email, phone: _phone)
        
        // show success message
        Util.showSuccessMessage(self, "User registered successfully!")
        
        // clear the fields
        self.name.text = ""
        self.email.text = ""
        self.phone.text = ""
        self.username.text = ""
        self.password.text = ""
        self.confirmPassword.text = ""
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
