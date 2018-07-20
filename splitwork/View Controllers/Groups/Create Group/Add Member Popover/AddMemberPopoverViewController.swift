//
//  AddMemberPopoverViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/23/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class AddMemberPopoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var members = [UserModel]()
    var filteredMembers = [UserModel]()
    
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var membersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var callback: ((_ member: UserModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurBackground()
        filteredMembers = members
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddMemberPopoverTableViewCell", for: indexPath) as? AddMemberPopoverTableViewCell else {
            fatalError("The dequeued cell is not an instance of AddMemberPopoverTableViewCell.")
        }
        
        // Configure the cell...
        let member = filteredMembers[indexPath.row]
        cell.name.text = member.name
        cell.username.text = member.username
        cell.profilePic.image = member.profilePic
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMembers = members
        } else {
            filteredMembers = members.filter{ ($0.name?.lowercased().contains(searchText.lowercased()))! || ($0.username?.lowercased().contains(searchText.lowercased()))! }
        }
        membersTableView.reloadData()
        print("table reloaded..")
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectButtonAction(_ sender: Any) {
        
        if let selectedIndex = membersTableView.indexPathForSelectedRow?.row {
            let selectedMember = members[selectedIndex]
            callback?(selectedMember)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func blurBackground() {
        popoverView.layer.cornerRadius = 5
        popoverView.layer.borderWidth = 0.75
        popoverView.layer.borderColor = UIColor.darkGray.cgColor
        self.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
    }
    
}
