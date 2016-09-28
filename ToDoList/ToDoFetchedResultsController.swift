//
//  ToDoFetchedResultsController.swift
//  ToDoList
//
//  Created by Amanda Harman on 9/28/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ToDoFetchedResultsController: NSFetchedResultsController<NSManagedObject>, NSFetchedResultsControllerDelegate {
    
    private let tableView: UITableView
    
    init(managedObjectContext: NSManagedObjectContext, withTableView tableView: UITableView){
        self.tableView = tableView
        super.init(fetchRequest: Item.itemFetchRequest as! NSFetchRequest<NSManagedObject>, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.delegate = self
        tryFetch()
    }

    func tryFetch(){
        do{
            try performFetch()
        }catch let error as NSError{
            print("Unresolved error: \(error), \(error.userInfo)")
        }
    }
    
    // Mark: NSFetchedResultsControllerDelegate 
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { return }
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .update, .move:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
}
