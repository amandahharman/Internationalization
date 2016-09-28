//
//  Item+CoreDataClass.swift
//  ToDoList
//
//  Created by Amanda Harman on 9/26/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    static let identifier = "Item"
    
    static let itemFetchRequest: NSFetchRequest = { () -> NSFetchRequest<NSFetchRequestResult> in
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }()

}
