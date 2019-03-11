//
//  GroupCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension GroupCD {
    
    // convenience initializer to allow creation of a GroupCD object via Academia CoreDataStack's managedObjectContext
    convenience init(groupUUID: UUID = UUID(),
                     active: Bool,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     name: String,
                     groupDescription: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.groupUUID = groupUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.name = name
        self.groupDescription = groupDescription
    }
}
