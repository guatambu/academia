//
//  StudentKidCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData


extension StudentKidCD {
    
    // convenience initializer to allow creation of a KidStudentCD object via Academia CoreDataStack's managedObjectContext
    convenience init(studentKidUUID: UUID = UUID(),
                     dateCreated: Date = Date(),
                     dateEdited: Date = Date(),
                     studentStatus: StudentStatusCD?,
                     belt: BeltCD,
                     profilePic: Data?,
                     username: String,
                     password: String,
                     firstName: String,
                     lastName: String,
                     parentGuardian: String,
                     address: AddressCD,
                     phone: String?,
                     mobile: String?,
                     email: String,
                     emergencyContact: EmergencyContactCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.kidStudentUUID = studentKidUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.studentStatus = studentStatus
        self.belt = belt
        self.profilePic = profilePic
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.parentGuardian = parentGuardian
        self.address = address
        self.phone = phone
        self.mobile = mobile
        self.email = email
        self.emergencyContact = emergencyContact
    }
}
