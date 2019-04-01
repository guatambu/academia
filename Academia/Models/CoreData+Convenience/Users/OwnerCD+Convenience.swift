//
//  OwnerCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData


extension OwnerCD {
    
    // convenience initializer to allow creation of an OwnerCD object via Academia CoreDataStack's managedObjectContext
    convenience init(ownerUUID: UUID = UUID(),
                     isInstructor: Bool = true,
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     birthdate: Date,
                     mostRecentPromotion: Date?,
                     studentStatus: StudentStatusCD?,
                     belt: BeltCD,
                     profilePic: Data?,
                     username: String,
                     password: String,
                     firstName: String,
                     lastName: String,
                     address: AddressCD,
                     phone: String?,
                     mobile: String?,
                     email: String,
                     emergencyContact: EmergencyContactCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.ownerUUID = ownerUUID
        self.isInstructor = isInstructor
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.mostRecentPromotion = mostRecentPromotion
        self.belt = belt
        self.profilePic = profilePic
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.phone = phone
        self.mobile = mobile
        self.email = email
        self.emergencyContact = emergencyContact
    }
}
