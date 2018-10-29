//
//  KidStudent+Convenience.swift
//  Academia
//
//  Created by Kelly Johnson on 10/7/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData


extension KidStudent {
    
    convenience init(kidUID: String,
                     dateCreated: Date,
                     dateEdited: Date,
                     birthdate: Date,
                     promotions: [String: Date]?,
                     mostRecentPromotion: Date?,
                     attendance: [Date]?,
                     studentStatus: [StudentStatus],
                     groups: [GroupX]?,
                     paymentProgram: PaymentProgramX?,
                     permission: [UserPermissions],
                     kidsBelt: KidsBeltX?,
                     profilePic: UIImage?,
                     username: String,
                     firstName: String,
                     lastName: String,
                     parentGuardian: String?,
                     streetAddress: String,
                     city: String,
                     state: String,
                     zipCode: String,
                     phone: String?,
                     mobile: String?,
                     email: String,
                     emergencyContact: String,
                     emergencyContactPhone: String,
                     emergencyContactRelationship: String,
                     context: NSManagedObjectContext
        ) {
        
        self.init(context: context)
        
        self.kidUID = kidUID
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.promotions = promotions
        self.mostRecentPromotion = mostRecentPromotion
        self.attendance = attendance
        self.studentStatus = studentStatus
        self.kidsBelt = kidsBelt
        self.groups = groups
        self.paymentProgram = paymentProgram
        self.permission = permission
        self.profilePic = profilePic
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.parentGuardian = parentGuardian
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.mobile = mobile
        self.email = email
        self.emergencyContact = emergencyContact
        self.emergencyContactPhone = emergencyContactPhone
        self.emergencyContactRelationship = emergencyContactRelationship
    }
    
}


//extension KidStudent: Equatable {
//    
//    static func ==(lhs: KidStudent, rhs: KidStudent) -> Bool {
//        if lhs.birthdate != rhs.birthdate { return false }
//        if lhs.city != rhs.city { return false }
//        if lhs.dateCreated != rhs.dateCreated { return false }
//        if lhs.dateEdited != rhs.dateEdited { return false }
//        if lhs.email != rhs.email { return false }
//        if lhs.emergencyContact != rhs.emergencyContact { return false }
//        if lhs.emergencyContactPhone != rhs.emergencyContactPhone { return false }
//        if lhs.emergencyContactRelationship != rhs.emergencyContactRelationship { return false }
//        if lhs.firstName != rhs.firstName { return false }
//        if lhs.kidUID != rhs.kidUID { return false }
//        if lhs.lastName != rhs.lastName { return false }
//        if lhs.permission != rhs.permission { return false }
//        if lhs.state != rhs.state { return false }
//        if lhs.streetAddress != rhs.streetAddress { return false }
//        if lhs.studentStatus != rhs.studentStatus { return false }
//        if lhs.username != rhs.username { return false }
//        if lhs.zipCode != rhs.zipCode { return false }
//        
//        return true
//    }
//}

