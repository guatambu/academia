//
//  EmergencyContactCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/04/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

extension EmergencyContactCD {
    
    // convenience initializer to allow creation of a EmergencyContactCD object via Academia CoreDataStack's managedObjectContext
    convenience init(name: String?,
                     phone: String?,
                     relationship: String?,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.phone = phone
        self.relationship = relationship
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
    }
}

