//
//  LocationModelController.swift
//  Academia
//
//  Created by Kelly Johnson on 9/18/18.
//  Copyright © 2018 DunDak, LLC. All rights reserved.
//

import UIKit

class LocationModelController {
    
    static let shared = LocationModelController()
    
    var locations = [Location]()
    
    
    // MARK: - CRUD Functions
    
    // Create
    func addNewLocation(profilePic: UIImage?, active: Bool, locationName: String, firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, phone: String, website: String, email: String) {
        
        let location = Location(locationUID: "004", active: active, dateCreated: Date(), dateEdited: Date(), profilePic: profilePic, locationName: locationName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, phone: phone, website: website, email: email, social: nil)
        
        locations.append(location)
    }
    
    // Read
    
    
    // Update
    
    
    // Delete
    func deleteLocation(location: Location) {
        guard let index = self.locations.index(of: location) else { return }
        self.locations.remove(at: index)
    }
    
    
}






























