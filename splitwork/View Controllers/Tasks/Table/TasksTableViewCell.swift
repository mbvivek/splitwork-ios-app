//
//  TasksTableViewCell.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/19/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var assignedTo: UILabel!
    @IBOutlet weak var assignedOn: UILabel!
    @IBOutlet weak var dueOn: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
