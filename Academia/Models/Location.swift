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
    let locationUID: String
    
    var active: Bool
    
    // Date
    var dateCreated: Date
    var dateEdited: Date
    
    // Images
    var profilePic: UIImage?
    
    // Strings
    var locationName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    var phone: String
    var website: String?
    var email: String?
    var social: String?
    
    // Basic Memberwise Initializer
    
    init(locationUID: String,
         active: Bool,
         dateCreated: Date,
         dateEdited: Date,
         profilePic: UIImage?,
         locationName: String,
         streetAddress: String,
         city: String,
         state: String,
         zipCode: String,
         phone: String,
         website: String?,
         email: String?,
         social: String?
        ) {
        
        self.locationUID = locationUID
        self.active = active
        self.dateCreated = dateCreated
        self.dateEdited = dateEdited
        self.profilePic = profilePic
        self.locationName = locationName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.phone = phone
        self.website = website
        self.email = email
        self.social = social
    }
    
}








































