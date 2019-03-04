//
//  StudentAdultCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

extension StudentAdultCD {
    
    // convenience initializer to allow creation of an AdultStudentCD object via Academia CoreDataStack's managedObjectContext
    convenience init(adultStudentUUID: UUID,
                     isInstructor: Bool,
                     dateCreated: Date,
                     dateEdited: Date,
                     birthdate: Date,
                     promotions: [String: Date]?,
                     mostRecentPromotion: Date?,
                     attendanceStudentAdult: NSSet?,
                     studentStatus: StudentStatusCD?,
                     groups: NSOrderedSet?,
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
                     emergencyContact: EmergencyContactCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.adultStudentUUID = adultStudentUUID
        self.isInstructor = isInstructor
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        //self.promotions = promotions
        self.mostRecentPromotion = mostRecentPromotion
        self.attendanceStudentAdult = attendanceStudentAdult
        self.studentStatus = studentStatus
        self.belt = belt
        self.groups = groups
        self.paymentProgram = paymentProgram
        //self.profilePic = profilePic
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


