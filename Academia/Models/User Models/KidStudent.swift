//
//  KidStudent.swift
//  Academia
//
//  Created by Kelly Johnson on 9/12/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class KidStudent {
    // MARK: - Properties
    
    // Date
    var dateCreated: Date
    var dateEdited: Date
    var birthdate: Date
    var promotions: [String: Date]?
    var mostRecentPromotion: Date?
    var attendance: [Date]?
    
    // Status
    var userStatus: [StudentStatus]
    
    // Data Model related
    var groups: [Group]?
    var paymentProgram: PaymentProgram?
    var permission: [UserPermissions]
    var kidsBelt: KidsBelt?
    
    // Images
    var profilePic: UIImage?
    
    // Strings
    var username: String
    var firstName: String
    var lastName: String
    var parentGuardian: String?
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    var phone: String?
    var mobile: String?
    var email: String
    var emergencyContact: String
    var emergencyContactPhone: String
    var emergencyContactRelationship: String
    
    
    // Basic Memberwise Initializer
    init(isKid: Bool,
         dateCreated: Date,
         dateEdited: Date,
         birthdate: Date,
         promotions: [String: Date]?,
         mostRecentPromotion: Date?,
         attendance: [Date]?,
         userStatus: [StudentStatus],
         groups: [Group]?,
         paymentProgram: PaymentProgram?,
         permission: [UserPermissions],
         kidsBelt: KidsBelt?,
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
         emergencyContactRelationship: String
        ) {
        
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.promotions = promotions
        self.mostRecentPromotion = mostRecentPromotion
        self.attendance = attendance
        self.userStatus = userStatus
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









































