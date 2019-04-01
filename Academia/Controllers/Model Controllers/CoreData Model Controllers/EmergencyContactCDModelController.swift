//
//  EmergencyContactCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class EmergencyContactCDModelController {
    
    // MARK: - Properties
    
    static let shared = EmergencyContactCDModelController()
    
    var emergencyContactInfo: [EmergencyContactCD] {
        let fetchRequest: NSFetchRequest<EmergencyContactCD> = EmergencyContactCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(emergencyContact: EmergencyContactCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(emergencyContact: EmergencyContactCD) {
        
        if let moc = emergencyContact.managedObjectContext {
            
            moc.delete(emergencyContact)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(emergencyContact: EmergencyContactCD,
                name: String?,
                phone: String?,
                relationship: String?) {
        
        emergencyContact.dateEdited = Date()
        
        if let name = name {
            emergencyContact.name = name
        }
        if let phone = phone {
            emergencyContact.phone = phone
        }
        if let relationship = relationship {
            emergencyContact.relationship = relationship
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
