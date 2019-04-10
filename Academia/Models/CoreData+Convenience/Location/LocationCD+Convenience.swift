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
    convenience init(locationUUID: UUID = UUID(),
                     active: Bool = true,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     locationPic: Data?,
                     locationName: String,
                     phone: String?,
                     website: String?,
                     email: String,
                     address: AddressCD,
                     socialLinks: LocationSocialLinksCD,
                     aula: AulaCD?,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.locationUUID = locationUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.locationPic = locationPic
        self.locationName = locationName
        self.address = address
        self.phone = phone
        self.website = website
        self.email = email
        self.socialLinks = socialLinks
    }
}
