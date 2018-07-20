//
//  GroupDetailMemberTableViewCell.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/27/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class GroupDetailMemberTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var role: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
