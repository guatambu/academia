//
//  LocationCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class LocationCDModelController {
    
    // MARK: - Properties
    
    static let shared = LocationCDModelController()
    
    var locations: [LocationCD] {
        let fetchRequest: NSFetchRequest<LocationCD> = LocationCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(location: LocationCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(location: LocationCD) {
        
        if let moc = location.managedObjectContext {
            
            moc.delete(location)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(location: LocationCD,
                locationPic: Data?,
                locationName: String?,
                address: AddressCD?,
                phone: String?,
                website: String?,
                email: String?,
                socialLinks: LocationSocialLinksCD?) {
        
        location.dateEdited = Date()
        
        if let locationName = locationName {
            location.locationName = locationName
        }
        if let address = address {
            location.address = address
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
        if let socialLinks = socialLinks {
            location.socialLinks = socialLinks
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
