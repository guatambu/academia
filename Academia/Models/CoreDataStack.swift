//
//  CoreDataStack.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Academia")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("ERROR: Unresolved error \(error), \(error.userInfo).  CoreDataStack.swift -> container - line 20.")
            }
        }
        return container
    }()
    static var context: NSManagedObjectContext { return container.viewContext }
}
