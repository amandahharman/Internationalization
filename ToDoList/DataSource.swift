//
//  DataSource.swift
//  ToDoList
//
//  Created by Amanda Harman on 9/28/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataSource: NSObject, UITableViewDataSource {
    
    private let tableView: UITableView
    
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    
    lazy var fetchedResultsController: ToDoFetchedResultsController = {
        let controller = ToDoFetchedResultsController(managedObjectContext: self.managedObjectContext, withTableView: self.tableView)
        return controller
    }()
    
    init(tableView: UITableView){
        self.tableView = tableView
    }
    
    func objectAt(indexPath: NSIndexPath) -> NSManagedObject {
        return fetchedResultsController.object(at: indexPath as IndexPath) 
    }
    
    // Mark: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else{return 0}
        return section.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return configureCell(cell: cell, atIndexPath: indexPath as IndexPath)
    }
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let item = fetchedResultsController.object(at: indexPath) as! Item
        cell.textLabel?.text = item.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = fetchedResultsController.object(at: indexPath)
        managedObjectContext.delete(item)
        DataController.sharedInstance.saveContext()
    }

}
