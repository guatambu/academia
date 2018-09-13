//
//  Owner.swift
//  Academia
//
//  Created by Kelly Johnson on 9/12/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class Owner {
    // MARK: - Properties
    
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
    var adultBasicBelt: AdultBasicBelt?
    var blackBelt: AdultBlackBelt?
    var groups: [Group]?
    
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
    init(isInstructor: Bool,
         dateCreated: Date,
         dateEdited: Date,
         birthdate: Date,
         promotions: [String: Date]?,
         mostRecentPromotion: Date?,
         attendance: [Date]?,
         groups: [Group]?,
         permission: UserPermissions,
         adultBasicBelt: AdultBasicBelt?,
         blackBelt: AdultBlackBelt?,
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











































