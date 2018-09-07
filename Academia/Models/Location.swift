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
    
    init(active: Bool,
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

//var myLocation = Location(active: true, dateCreated: Date(), dateEdited: Date(), profilePic: #imageLiteral(resourceName: "download.jpg"), locationName: "my location", streetAddress: "1267 the spot blvd.", city: "you know", state: "LA", zipCode: "09854", phone: "987-876-1230", website: "www.theschool.gov", email: "email@theschool.gov", social: nil)








































