//
//  EditProfileViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/27/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var saveProfileButton: UIButton!
    @IBOutlet weak var cancelProfileButton: UIButton!
    
    @IBOutlet weak var currentPassword: UITextField!
    
    @IBOutlet weak var cardType: UITextField!
    @IBOutlet weak var nameOnCard: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expiryMonth: UITextField!
    @IBOutlet weak var expiryYear: UITextField!
    @IBOutlet weak var cvv: UITextField!
    
    @IBOutlet weak var editCardButton: UIButton!
    @IBOutlet weak var saveCardButton: UIButton!
    @IBOutlet weak var cancelCardButton: UIButton!
    
    
    var cardExists: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserService.shared().syncUsers(onSync: nil)
        CardService.shared().syncCards(onSync: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let loggedInUserUsername = LoggedInUser.shared.getUser() {
            if let loggedInUser = Business.shared().users?.getUser(username: loggedInUserUsername) {
                print("loggedInUser = \((loggedInUser.username)!)")
                username.text = loggedInUser.username
                name.text = loggedInUser.name
                email.text = loggedInUser.email
                phone.text = loggedInUser.phone
                
                if loggedInUser.creditCardId != "" {
                    cardExists = true
                    
                    // get the card from credit card service and disply the data
                    let card = Business.shared().cards?.getCreditCard(id: loggedInUser.creditCardId!)
                    
                    cardType.text = card?.type
                    nameOnCard.text = card?.nameOnCard
                    cardNumber.text = card?.number
                    expiryMonth.text = card?.expiryMonth
                    expiryYear.text = card?.expiryYear
                    cvv.text = card?.cvv
                    
                    
                } else {
                    // allow the user to add new card
                    saveCardButton.isHidden = false
                    editCardButton.isHidden = true
                    
                    cardType.isEnabled = true
                    nameOnCard.isEnabled = true
                    cardNumber.isEnabled = true
                    expiryMonth.isEnabled = true
                    expiryYear.isEnabled = true
                    cvv.isEnabled = true
                }
                
            } else {
                Util.showErrorMessage(self, "Invalid Session!")
            }
        } else {
            Util.showErrorMessage(self, "Invalid Session!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changePasswordButtonAction(_ sender: Any) {
        
        if let loggedInUser = Util.getLoggedInUser() {
            let alertController = UIAlertController(title: "Change Password", message: "Enter the new password", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "New Password"
                textField.isSecureTextEntry = true
            }
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                let newPasswordTextField = alertController.textFields![0] as UITextField
                let newPassword = newPasswordTextField.text!
                if(newPassword == "" || newPassword.count < 6) {
                    Util.showErrorMessage(self, "Unable to change password! (New password should be at least 6 characters)")
                    return
                } else {
                    UserService.shared().updatePassword(userId: loggedInUser.id!, password: newPassword)
                    Util.showSuccessMessage(self, "Changed password successfully!")
                }
                
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            
            let _currentPassword = self.currentPassword.text!
            if(_currentPassword == "") {
                Util.showErrorMessage(self, "Please enter the current password")
                return
            }
            
            print("_currentPassword = \(_currentPassword), loggedInUser.password = \(loggedInUser.password)")
            if(String(_currentPassword.hashValue) != loggedInUser.password) {
                Util.showErrorMessage(self, "Incorrect current password!")
                return
            } else {
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func configurationTextField(newPassword: UITextField!) {
        
    }
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
        
        editProfileButton.isHidden = true
        cancelProfileButton.isHidden = false
        saveProfileButton.isHidden = false
        
        name.isEnabled = true
        email.isEnabled = true
        phone.isEnabled = true
        
    }
    
    @IBAction func cancelProfileButtonAction(_ sender: Any) {
        
        editProfileButton.isHidden = false
        cancelProfileButton.isHidden = true
        saveProfileButton.isHidden = true
        
    }
    
    @IBAction func saveProfileButtonAction(_ sender: Any) {
        
        if let loggedInUserUsername = LoggedInUser.shared.getUser() {
            if let loggedInUser = Business.shared().users?.getUser(username: loggedInUserUsername) {
                
                let _name = name.text!
                let _email = email.text!
                let _phone = phone.text!
                
                if(_name == "" || _email == "" || _phone == "") {
                    Util.showErrorMessage(self, "Please fill all fields!")
                    return
                }
                
                if(!Util.isValidEmail(testEmail: _email)) {
                    Util.showErrorMessage(self, "Invalid email!")
                    return
                }
                
                if(!Util.isValidPhone(testPhone: _phone)) {
                    Util.showErrorMessage(self, "Invalid phone!")
                    return
                }
                
                UserService.shared().updateUser(userId: loggedInUser.id!, name: _name, email: _email, phone: _phone)
                Util.showSuccessMessage(self, "Profile updated successfully")
                
            }
        }
    }
    
    
    
    
    @IBAction func editCardButtonAction(_ sender: Any) {
        
        editCardButton.isHidden = true
        cancelCardButton.isHidden = false
        saveCardButton.isHidden = false
        
        cardType.isEnabled = true
        nameOnCard.isEnabled = true
        cardNumber.isEnabled = true
        expiryMonth.isEnabled = true
        expiryYear.isEnabled = true
        cvv.isEnabled = true
        
    }
    
    @IBAction func cancelCardButtonAction(_ sender: Any) {
        
        editCardButton.isHidden = false
        cancelCardButton.isHidden = true
        saveCardButton.isHidden = true
        
        cardType.isEnabled = false
        nameOnCard.isEnabled = false
        cardNumber.isEnabled = false
        expiryMonth.isEnabled = false
        expiryYear.isEnabled = false
        cvv.isEnabled = false
        
    }
    
    @IBAction func saveCardButtonAction(_ sender: Any) {
        
        if let loggedInUserUsername = LoggedInUser.shared.getUser() {
            if let loggedInUser = Business.shared().users?.getUser(username: loggedInUserUsername) {
                
                let _cardType = cardType.text!
                let _nameOnCard = nameOnCard.text!
                let _cardNumber = cardNumber.text!
                let _expiryMonth = expiryMonth.text!
                let _expiryYear = expiryYear.text!
                let _cvv = cvv.text!
                
                if(_cardType == "" || _nameOnCard == "" || _cardNumber == "" || _expiryMonth == "" || _expiryYear == "" || _cvv == "") {
                    Util.showErrorMessage(self, "Please fill all the fields!")
                    return
                }
                
                //check for card number
                if(!(Util.isInteger(testString: _cardNumber) && _cardNumber.count == 16)) {
                    Util.showErrorMessage(self, "Invalid card number! (Should have 16 digits)")
                    return
                }
                
                // check for expiry month
                if(!Util.isInteger(testString: _expiryMonth)) {
                    Util.showErrorMessage(self, "Invalid expiry month!")
                    return
                }
                
                // check if month is btw 1 and 12
                if let monthInInt = Int(_expiryMonth) {
                    if(monthInInt < 1 || monthInInt > 12) {
                        Util.showErrorMessage(self, "Invalid expiry month! (Should be between 01 to 12)")
                        return
                    }
                }
                
                // check for expiry year
                if(!Util.isInteger(testString: _expiryYear)) {
                    Util.showErrorMessage(self, "Invalid expiry year!")
                    return
                }
                
                // check if year is 2018 and above
                let today = Date()
                let calendar = Calendar.current
                let year = calendar.component(.year, from: today)
                let month = calendar.component(.month, from: today)
                
                if let monthInInt = Int(_expiryMonth), let yearInInt = Int(_expiryYear) {
                    if(yearInInt < year || (yearInInt == year && monthInInt < month)) {
                        Util.showErrorMessage(self, "Invalid expiry date!")
                        return
                    }
                }
                
                // check if cvv is exactly 3 digits
                if(_cvv.count != 3) {
                    Util.showErrorMessage(self, "Invalid CVV! (Should have 3 digits)")
                    return
                }
                
                if cardExists {
                    // patch
                    CardService.shared().updateCard(cardId: loggedInUser.creditCardId!, type: _cardType, nameOnCard: _nameOnCard, number: _cardNumber, expMonth: _expiryMonth, expYear: _expiryYear, cvv: _cvv)
                    Util.showSuccessMessage(self, "Card is successfully updated!")
                } else {
                    // post
                    CardService.shared().addCard(userId: loggedInUser.id!, type: _cardType, nameOnCard: _nameOnCard, number: _cardNumber, expMonth: _expiryMonth, expYear: _expiryYear, cvv: _cvv)
                    Util.showSuccessMessage(self, "Card is successfully added!")
                }
                
                cardExists = true
                
                cardType.isEnabled = false
                nameOnCard.isEnabled = false
                cardNumber.isEnabled = false
                expiryMonth.isEnabled = false
                expiryYear.isEnabled = false
                cvv.isEnabled = false
                
                saveCardButton.isHidden = true
                cancelCardButton.isHidden = true
                editCardButton.isHidden = false
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
