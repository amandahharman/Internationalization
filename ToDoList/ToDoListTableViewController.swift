//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Amanda Harman on 9/26/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import UIKit
import CoreData

class ToDoListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    lazy var dataSource: DataSource = {
        return DataSource(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItem" {
            guard let destinationVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC.item = dataSource.objectAt(indexPath: indexPath as NSIndexPath) as? Item
        }
    }

        
    // Mark: - Table view delegate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    

}

  
