//
//  DashboardViewController.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let loggedInUser = Util.getLoggedInUser() {
            name.text = loggedInUser.name
            username.text = loggedInUser.username
            profilePic.image = loggedInUser.profilePic
        } else {
            Util.showErrorMessage(self, "Invalid Session!")
            Util.clearLoggedInUser(self)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeProfilePicAction(_ sender: UILongPressGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        if let _loggedInUserUsername = LoggedInUser.shared.getUser() {
            if let _loggedInUser = Business.shared().users?.getUser(username: _loggedInUserUsername) {
                UserService.shared().updateProfilePic(userId: _loggedInUser.id!, profilePic: newImage)
            }
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        
        // clear the LoggedInUser in core data
        LoggedInUser.shared.clear()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(loginViewController, animated:true, completion:nil)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: Actions
    
    
}
