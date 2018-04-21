//
//  TasksViewController.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/19/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    
    
    var tasks = ["Cleaning", "Rental Car"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentfier = "TasksTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentfier, for: indexPath) as? TasksTableViewCell else {
            fatalError("The dequeued cell is not an instance of TasksTableViewCell.")
        }
        
        // Configure the cell...
        cell.taskName.text = tasks[indexPath.row]
        
        return cell
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
