//
//  KidStudentCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData


extension StudentKidCD {
    
    // convenience initializer to allow creation of a KidStudentCD object via Academia CoreDataStack's managedObjectContext
    convenience init(kidStudentUUID: UUID,
                     dateCreated: Date,
                     dateEdited: Date,
                     birthdate: Date,
                     promotions: BeltPromotionCD?,
                     mostRecentPromotion: Date?,
                     attendanceStudentKid: NSSet?,
                     studentStatus: StudentStatusCD?,
                     groups: NSSet?,
                     paymentProgram: PaymentProgramCD?,
                     belt: BeltCD,
                     profilePic: UIImage?,
                     username: String,
                     password: String,
                     firstName: String,
                     lastName: String,
                     parentGuardian: String,
                     address: AddressCD,
                     phone: String?,
                     mobile: String?,
                     email: String,
                     emergencyContactInfo: EmergencyContactInfoCD,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.kidStudentUUID = kidStudentUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        //self.promotions = promotions
        self.mostRecentPromotion = mostRecentPromotion
        self.attendanceStudentKid = attendanceStudentKid
        self.studentStatus = studentStatus
        self.belt = belt
        self.groups = groups
        self.paymentProgram = paymentProgram
        //self.profilePic = profilePic
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.parentGuardian = parentGuardian
        self.address = address
        self.phone = phone
        self.mobile = mobile
        self.email = email
        self.emergencyContactInfo = emergencyContactInfo
    }
}
