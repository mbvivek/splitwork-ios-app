//
//  AddMemberPopoverTableViewCell.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/22/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class AddMemberPopoverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
