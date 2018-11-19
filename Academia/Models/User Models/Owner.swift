//
//  Owner.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/12/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class Owner {
    // MARK: - Properties
    
    // UID
    let ownerUID: UUID
    
    // Bool
    var isInstructor: Bool
    
    // Date
    var dateCreated: Date
    var dateEdited: Date
    var birthdate: Date
    var promotions: [String: Date]?
    var mostRecentPromotion: Date?
    var attendance: [Date]?
    
    // Data Model related
    var permission: UserPermissions
    var belt: Belt
    var groups: [Group]?
    
    // Images
    var profilePic: UIImage?
    
    // Strings
    var username: String
    var password: String
    var firstName: String
    var lastName: String
    var addressLine1: String
    var addressLine2: String
    var city: String
    var state: String
    var zipCode: String
    var phone: String?
    var mobile: String?
    var email: String
    var emergencyContactName: String
    var emergencyContactPhone: String
    var emergencyContactRelationship: String
    
    
    // Basic Memberwise Initializer
    init(ownerUID: UUID,
         isInstructor: Bool,
         dateCreated: Date,
         dateEdited: Date,
         birthdate: Date,
         promotions: [String: Date]?,
         mostRecentPromotion: Date?,
         attendance: [Date]?,
         groups: [Group]?,
         permission: UserPermissions,
         belt: Belt,
         profilePic: UIImage?,
         username: String,
         password: String,
         firstName: String,
         lastName: String,
         addressLine1: String,
         addressLine2: String,
         city: String,
         state: String,
         zipCode: String,
         phone: String,
         mobile: String?,
         email: String,
         emergencyContactName: String,
         emergencyContactPhone: String,
         emergencyContactRelationship: String
        ) {
        
        self.ownerUID = ownerUID
        self.isInstructor = isInstructor
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.promotions = promotions
        self.mostRecentPromotion = mostRecentPromotion
        self.attendance = attendance
        self.belt = belt
        self.groups = groups
        self.permission = permission
        self.profilePic = profilePic
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
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

extension Owner: Equatable {

    static func ==(lhs: Owner, rhs: Owner) -> Bool {
        if lhs.ownerUID != rhs.ownerUID { return false }
        if lhs.isInstructor != rhs.isInstructor { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.birthdate != rhs.birthdate { return false }
        if lhs.permission != rhs.permission { return false }
        if lhs.belt != rhs.belt { return false }
        if lhs.username != rhs.username { return false }
        if lhs.password != rhs.password { return false }
        if lhs.firstName != rhs.firstName { return false }
        if lhs.lastName != rhs.lastName { return false }
        if lhs.addressLine1 != rhs.addressLine1 { return false }
        if lhs.addressLine2 != rhs.addressLine2 { return false }
        if lhs.city != rhs.city { return false }
        if lhs.state != rhs.state { return false }
        if lhs.zipCode != rhs.zipCode { return false }
        if lhs.phone != rhs.phone { return false }
        if lhs.mobile != rhs.mobile { return false }
        if lhs.email != rhs.email { return false }
        if lhs.emergencyContactName != rhs.emergencyContactName { return false }
        if lhs.emergencyContactPhone != rhs.emergencyContactPhone { return false }
        if lhs.emergencyContactRelationship != rhs.emergencyContactRelationship { return false }

        return true
    }
}









































