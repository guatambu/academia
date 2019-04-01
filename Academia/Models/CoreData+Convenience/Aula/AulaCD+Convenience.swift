//
//  AulaCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


extension AulaCD {
    
    // convenience initializer to allow creation of a AulaCD object via Academia CoreDataStack's managedObjectContext
    convenience init(aulaUUID: UUID = UUID(),
                     active: Bool,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     aulaName: String,
                     aulaDescription: String,
                     dayOfTheWeek: String,
                     time: String,
                     timeCode: Int16,
                     location: LocationCD?,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.aulaUUID = aulaUUID
        self.active = active
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.aulaName = aulaName
        self.aulaDescription = aulaDescription
        self.dayOfTheWeek = dayOfTheWeek
        self.time = time
        self.timeCode = timeCode
        self.location = location
    }
}
