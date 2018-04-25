//
//  WalletTableViewCell.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell {

    //MARK: Variables
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var youOwe: UILabel!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var owesYou: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
