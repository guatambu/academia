//
//  LocationSocialLinksCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class LocationSocialLinksCDModelController {
    
    // MARK: - Properties
    
    static let shared = LocationSocialLinksCDModelController()
    
    var locationSocialLinks: [LocationSocialLinksCD] {
        let fetchRequest: NSFetchRequest<LocationSocialLinksCD> = LocationSocialLinksCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(locationSocialLinks: LocationSocialLinksCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(locationSocialLinks: LocationSocialLinksCD) {
        
        if let moc = locationSocialLinks.managedObjectContext {
            
            moc.delete(locationSocialLinks)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(locationSocialLinks: LocationSocialLinksCD,
                socialLink1: String?,
                socialLink2: String?,
                socialLink3: String?) {
        
        locationSocialLinks.dateEdited = Date()
        
        if let socialLink1 = socialLink1 {
            locationSocialLinks.socialLink1 = socialLink1
        }
        if let socialLink2 = socialLink2 {
            locationSocialLinks.socialLink2 = socialLink2
        }
        if let socialLink3 = socialLink3 {
            locationSocialLinks.socialLink3 = socialLink3
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
