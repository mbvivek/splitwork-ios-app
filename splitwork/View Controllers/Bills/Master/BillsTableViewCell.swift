//
//  BillsTableViewCell.swift
//  splitwork
//
//  Created by Swathi Kommaghatta Chandrashekaraiah on 4/23/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class BillsTableViewCell: UITableViewCell {

    //MARK: Variables
    @IBOutlet weak var billNames: UILabel!
    @IBOutlet weak var oweLabel: UILabel!
    @IBOutlet weak var addedBy: UILabel!
    @IBOutlet weak var oweAmount: UILabel!
    @IBOutlet weak var group: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
