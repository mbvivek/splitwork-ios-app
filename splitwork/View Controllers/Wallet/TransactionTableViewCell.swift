//
//  TransactionTableViewCell.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/25/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var paidAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
