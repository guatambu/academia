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
    convenience init(ownerUUID: UUID,
                     isInstructor: Bool,
                     dateCreated: Date,
                     dateEdited: Date,
                     birthdate: Date,
                     promotions: [String: Date]?,
                     mostRecentPromotion: Date?,
                     attendanceOwner: NSSet?,
                     studentStatus: StudentStatusCD?,
                     groups: NSSet?,
                     paymentProgram: PaymentProgramCD?,
                     belt: BeltCD,
                     profilePic: UIImage?,
                     username: String,
                     password: String,
                     firstName: String,
                     lastName: String,
                     address: AddressCD,
                     phone: String?,
                     mobile: String?,
                     email: String,
                     emergencyContactInfo: EmergencyContactInfoCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.ownerUUID = ownerUUID
        self.isInstructor = isInstructor
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        //self.promotions = promotions
        self.mostRecentPromotion = mostRecentPromotion
        self.attendanceOwner = attendanceOwner
        self.belt = belt
        self.groups = groups
        //self.profilePic = profilePic
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.phone = phone
        self.mobile = mobile
        self.email = email
        self.emergencyContactInfo = emergencyContactInfo
    }
}
