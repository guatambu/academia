//
//  LocationModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 9/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit
import CoreData

class LocationModelController {
    
    static let shared = LocationModelController()
    
    var locations = [Location]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNew(locationPic: UIImage?,
                active: Bool,
                locationName: String,
                addressLine1: String,
                addressLine2: String,
                city: String,
                state: String,
                zipCode: String,
                phone: String,
                website: String,
                email: String,
                social1: String,
                social2: String,
                social3: String
        ) {
        
        let location = Location(locationUID: UUID(), active: active, dateCreated: Date(), dateEdited: Date(), locationPic: locationPic, locationName: locationName, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, phone: phone, website: website, email: email, social1: social1, social2: social2, social3: social3)
        
        locations.append(location)
    }
    
    // Read
    
    
    // Update
    func update(location: Location,
                active: Bool?,
                locationPic: UIImage?,
                locationName: String?,
                addressLine1: String?,
                addressLine2: String?,
                city: String?,
                state: String?,
                zipCode: String?,
                phone: String?,
                website: String?,
                email: String?,
                social1: String?,
                social2: String?,
                social3: String?) {
        
        location.dateEdited = Date()
        
        if let active = active {
            location.active = active
        }
        if let locationPic = locationPic {
            location.locationPic = locationPic
        }
        if let locationName = locationName {
            location.locationName = locationName
        }
        if let addressLine1 = addressLine1 {
            location.addressLine1 = addressLine1
        }
        if let addressLine2 = addressLine2 {
            location.addressLine2 = addressLine2
        }
        if let city = city {
            location.city = city
        }
        if let state = state {
            location.state = state
        }
        if let zipCode = zipCode {
            location.zipCode = zipCode
        }
        if let phone = phone {
            location.phone = phone
        }
        if let website = website {
            location.website = website
        }
        if let email = email {
            location.email = email
        }
        if let social1 = social1 {
            location.social1 = social1
        }
        if let social2 = social2 {
            location.social2 = social2
        }
        if let social3 = social3 {
            location.social3 = social3
        }
    }
    
    
    // Delete
    func delete(location: Location) {
        guard let index = self.locations.firstIndex(of: location) else { return }
        self.locations.remove(at: index)
    }
    
    
}






























