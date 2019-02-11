//
//  KidStudentCD+Convenience.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 2/10/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData


extension KidStudentCD {
    
    // convenience initializer to allow creation of a KidStudentCD object via Academia CoreDataStack's managedObjectContext
    convenience init(kidStudentUUID: UUID,
                     dateCreated: Date,
                     dateEdited: Date,
                     birthdate: Date,
                     promotions: [String: Date]?,
                     mostRecentPromotion: Date?,
                     attendanceKidStudent: AttendanceCD?,
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
                     addressLine1: String,
                     addressLine2: String,
                     city: String,
                     state: String,
                     zipCode: String,
                     phone: String?,
                     mobile: String?,
                     email: String,
                     emergencyContactName: String,
                     emergencyContactPhone: String,
                     emergencyContactRelationship: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.kidStudentUUID = kidStudentUUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.promotions = promotions
        self.mostRecentPromotion = mostRecentPromotion
        self.attendanceKidStudent = attendanceKidStudent
        self.studentStatus = studentStatus
        self.belt = belt
        self.groups = groups
        self.paymentProgram = paymentProgram
        self.profilePic = profilePic
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.parentGuardian = parentGuardian
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.mobile = mobile
        self.email = email
        self.emergencyContactName = emergencyContactName
        self.emergencyContactPhone = emergencyContactPhone
        self.emergencyContactRelationship = emergencyContactRelationship
        
    }
    
    
}
