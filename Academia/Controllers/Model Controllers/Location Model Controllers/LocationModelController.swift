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
    func addNew(profilePic: UIImage?, active: Bool, locationName: String, firstName: String, lastName: String, addressLine1: String, addressLine2: String, city: String, state: String, zipCode: String, phone: String, website: String, email: String, social: String?) {
        
        let location = Location(locationUID: UUID(), active: active, dateCreated: Date(), dateEdited: Date(), profilePic: profilePic, locationName: locationName, addressLine1: addressLine1, addressLine2: addressLine2, city: city, state: state, zipCode: zipCode, phone: phone, website: website, email: email, social: social)
        
        locations.append(location)
    }
    
    // Read
    
    
    // Update
    func update(location: Location, active: Bool, city: String, email: String, locationName: String, phone: String, profilePic: UIImage?, social: String, state: String, addressLine1: String, addressLine2: String, website: String, zipCode: String) {
        
        location.active = active
        location.city = city
        location.dateEdited = Date()
        location.email = email
        location.locationName = locationName
        location.phone = phone
        location.profilePic = profilePic
        location.social = social
        location.state = state
        location.addressLine1 = addressLine1
        location.addressLine2 = addressLine2
        location.website = website
        location.zipCode = zipCode
        
    }
    
    
    // Delete
    func delete(location: Location) {
        guard let index = self.locations.index(of: location) else { return }
        self.locations.remove(at: index)
    }
    
    
}






























