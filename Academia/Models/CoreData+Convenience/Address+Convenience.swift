//
//  Address+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/26/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

extension AddressCD {
    
    // convenience initializer to allow creation of a AddressCD object via Academia CoreDataStack's managedObjectContext
    convenience init(addressLine1: String,
                     addressLine2: String,
                     city: String,
                     state: String,
                     zipCode: String,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
    }
}

