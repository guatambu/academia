//
//  LocationCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData


extension LocationCD {
    
    // convenience initializer to allow creation of a LocationCD object via Academia CoreDataStack's managedObjectContext
    convenience init(locationUUID: UUID,
                     active: Bool,
                     dateCreated: Date,
                     dateEdited: Date,
                     locationPic: UIImage?,
                     locationName: String,
                     addressLine1: String,
                     addressLine2: String,
                     city: String,
                     state: String,
                     zipCode: String,
                     phone: String?,
                     website: String?,
                     email: String,
                     socialLink1: String,
                     socialLink2: String,
                     socialLink3: String,
                     aula: AulaCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.locationUUID = locationUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.locationPic = locationPic
        self.locationName = locationName
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.website = website
        self.email = email
        self.socialLink1 = socialLink1
        self.socialLink2 = socialLink2
        self.socialLink3 = socialLink3
        
    }
    
}
