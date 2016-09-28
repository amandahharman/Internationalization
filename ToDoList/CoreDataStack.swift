//
//  CoreDataStack.swift
//  ToDoList
//
//  Created by Amanda Harman on 9/26/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import Foundation
import CoreData

/*
 
 So it basically creates persistant store coordinator. It then creates a persistant store of SQLLite type and places that sqlite file in the document directory. It then createds a managed object context and declares its coordinator as the one that we just made.
 
 The context is like a scratchpad that takes notes of all the changes and then waits for us to tell it to execute
 
 An object graph is a collection of different objects along with the relationships between the objects
 
 */


public class DataController: NSObject {
    
    static let sharedInstance = DataController()
    private override init(){}
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1 ] as NSURL
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
       let modelURL = Bundle.main.url(forResource: "ToDoList", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    private lazy var persistantStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("ToDoList.sqlite")
        
        do{
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            let userInfo: [String: AnyObject] = [
                NSLocalizedDescriptionKey: "Failed to initialize the application's saved data" as AnyObject,
                NSLocalizedFailureReasonErrorKey: "There was an error creting or loading the application's saved data" as AnyObject,
                NSUnderlyingErrorKey: error as NSError
            ]
        
            let wrappedError = NSError(domain: "com.aharman.CoreDataError", code: 9999, userInfo: userInfo)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
            
        }
        
        return coordinator
    }()
    
    public lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistantStoreCoordinator
        return managedObjectContext
    }()
    
    public func saveContext(){
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

}
