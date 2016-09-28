//
//  Item+CoreDataProperties.swift
//  ToDoList
//
//  Created by Amanda Harman on 9/26/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var text: String?
    @NSManaged public var completed: Bool

}
