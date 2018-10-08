//
//  OwnerX.swift
//  Academia
//
//  Created by Kelly Johnson on 9/12/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class OwnerX {
    // MARK: - Properties
    
    // UID
    let ownerUID: String
    
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
    var adultBasicBelt: AdultBasicBeltX?
    var blackBelt: AdultBlackBeltX?
    var groups: [GroupX]?
    
    // Images
    var profilePic: UIImage?
    
    // Strings
    var username: String
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    var phone: String?
    var mobile: String?
    var email: String
    
    
    // Basic Memberwise Initializer
    init(ownerUID: String,
         isInstructor: Bool,
         dateCreated: Date,
         dateEdited: Date,
         birthdate: Date,
         promotions: [String: Date]?,
         mostRecentPromotion: Date?,
         attendance: [Date]?,
         groups: [GroupX]?,
         permission: UserPermissions,
         adultBasicBelt: AdultBasicBeltX?,
         blackBelt: AdultBlackBeltX?,
         profilePic: UIImage?,
         username: String,
         firstName: String,
         lastName: String,
         streetAddress: String,
         city: String,
         state: String,
         zipCode: String,
         phone: String?,
         mobile: String?,
         email: String
        ) {
        
        self.ownerUID = ownerUID
        self.isInstructor = isInstructor
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.birthdate = birthdate
        self.promotions = promotions
        self.mostRecentPromotion = mostRecentPromotion
        self.attendance = attendance
        self.adultBasicBelt = adultBasicBelt
        self.blackBelt = blackBelt
        self.groups = groups
        self.permission = permission
        self.profilePic = profilePic
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.mobile = mobile
        self.email = email
    }
    
}

extension OwnerX: Equatable {

    static func ==(lhs: OwnerX, rhs: OwnerX) -> Bool {
        if lhs.birthdate != rhs.birthdate { return false }
        if lhs.city != rhs.city { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.email != rhs.email { return false }
        if lhs.firstName != rhs.firstName { return false }
        if lhs.isInstructor != rhs.isInstructor { return false }
        if lhs.lastName != rhs.lastName { return false }
        if lhs.mobile != rhs.mobile { return false }
        if lhs.ownerUID != rhs.ownerUID { return false }
        if lhs.permission != rhs.permission { return false }
        if lhs.phone != rhs.phone { return false }
        if lhs.state != rhs.state { return false }
        if lhs.streetAddress != rhs.streetAddress { return false }
        if lhs.username != rhs.username { return false }
        if lhs.zipCode != rhs.zipCode { return false }

        return true
    }
}









































