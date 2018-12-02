//
//  Location.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 8/17/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class Location {
    
    // MARK: - Properties
    
    // UID
    let locationUID: UUID
    
    var active: Bool
    
    // Date
    var dateCreated: Date
    var dateEdited: Date
    
    // Images
    var locationPic: UIImage?
    
    // Strings
    var locationName: String
    var addressLine1: String
    var addressLine2: String
    var city: String
    var state: String
    var zipCode: String
    var phone: String
    var website: String?
    var email: String?
    var social1: String?
    var social2: String?
    var social3: String?


    
    // Basic Memberwise Initializer
    
    init(locationUID: UUID,
         active: Bool,
         dateCreated: Date,
         dateEdited: Date,
         locationPic: UIImage?,
         locationName: String,
         addressLine1: String,
         addressLine2: String,
         city: String,
         state: String,
         zipCode: String,
         phone: String,
         website: String?,
         email: String?,
         social1: String?,
         social2: String?,
         social3: String?
        ) {
        
        self.locationUID = locationUID
        self.active = active
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.locationPic = locationPic
        self.locationName = locationName
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.website = website
        self.email = email
        self.social1 = social1
        self.social2 = social2
        self.social3 = social3
    }
    
}

extension Location: Equatable {
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        if lhs.city != rhs.city { return false }
        if lhs.dateCreated != rhs.dateCreated { return false }
        if lhs.dateEdited != rhs.dateEdited { return false }
        if lhs.email != rhs.email { return false }
        if lhs.locationName != rhs.locationName { return false }
        if lhs.locationUID != rhs.locationUID { return false }
        if lhs.state != rhs.state { return false }
        if lhs.addressLine1 != rhs.addressLine1 { return false }
        if lhs.addressLine2 != rhs.addressLine2 { return false }
        if lhs.zipCode != rhs.zipCode { return false }
        if lhs.social1 != rhs.social1 { return false }
        if lhs.social2 != rhs.social2 { return false }
        if lhs.social3 != rhs.social3 { return false }
        
        return true
    }
}







































