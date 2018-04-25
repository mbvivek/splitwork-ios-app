//
//  WalletTableViewCell.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/24/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell {

    //MARK: Variables
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var youOwe: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var owesYou: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
