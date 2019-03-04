//
//  AddressCDModelController.swift
//  Academia
//
//  Created by Michael Guatambu Davis on 3/3/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData

class AddressCDModelController {
    
    // MARK: - Properties
    
    static let shared = AddressCDModelController()
    
    var addresses: [AddressCD] {
        let fetchRequest: NSFetchRequest<AddressCD> = AddressCD.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("ERROR: there was an error fetching owners. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - CRUD Functions
    
    // MARK: - Create
    func add(address: AddressCD) {
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
    
    // MARK: - Delete
    func remove(address: AddressCD) {
        
        if let moc = address.managedObjectContext {
            
            moc.delete(address)
            OwnerCDModelController.shared.saveToPersistentStorage()
        }
        
    }
    
    // MARK: - Update
    func update(address: AddressCD,
                addressLine1: String?,
                addressLine2: String?,
                city: String?,
                state: String?,
                zipCode: String?) {
        
        address.dateEdited = Date()
    
        if let addressLine1 = addressLine1 {
            address.addressLine1 = addressLine1
        }
        if let addressLine2 = addressLine2 {
            address.addressLine2 = addressLine2
        }
        if let city = city {
            address.city = city
        }
        if let state = state {
            address.state = state
        }
        if let zipCode = zipCode {
            address.zipCode = zipCode
        }
        
        OwnerCDModelController.shared.saveToPersistentStorage()
    }
}
